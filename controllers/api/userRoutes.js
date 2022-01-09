const router = require('express').Router();
const { User, Comment, Blog } = require('../../models');


router.get('/', async (req, res) => {
  try {
    const userData = await User.findAll({
  })
    res.status(200).json(userData);
} catch {
  res.status(400).json(error);

      }
});

router.get('/:id', async (req, res) => {
  try {
    const userData = await User.findOne({
      where: {
          id: req.params.id
      },
      include: [
          {
              model: Blog,
              attributes: ['id', 'title', 'description', 'date_created']
          },
          {
              model: Comment,
              attributes: ['id', 'comment'],
              include: {
                  model: User,
                  attributes: ['name']
              }
          }
      ]
  })
  res.status(200).json(userData);

} catch {
  res.status(400).json(error);
}

});

router.post('/', async (req, res) => {
  try {
    const userData = await User.create(req.body);

    req.session.save(() => {
      req.session.user_id = userData.id;
      req.session.logged_in = true;

      res.status(200).json(userData);
    });
  } catch (error) {
    res.status(400).json(error);
  }
});

router.post('/signup', async (req, res) => {
  try {
    const userName = await User.findOne({ where: { username: req.body.username } });
    if (!userName) {
      res
        .status(400)
        .json({ message: 'Name required, please enter your name!' });
      return;
    }

    const userData = await User.findOne({ where: { email: req.body.email } });
    if (!userData) {
      res
        .status(400)
        .json({ message: 'Enter a correct email address, please try again' });
      return;
    }

    const validPassword = await userData.checkPassword(req.body.password);
    if (!validPassword) {
      res
        .status(400)
        .json({ message: 'Incorrect password, please try again' });
      return;
    }

    req.session.save(() => {
      req.session.user_id = userData.id;
      req.session.logged_in = true;
      
      res.json({ user: userData, message: 'You are now logged in!' });
    });

  } catch (error) {
    res.status(400).json(error);
  }
});

router.post('/login', async (req, res) => {
  try {
    const userData = await User.findOne({ where: { email: req.body.email } });

    if (!userData) {
      res
        .status(400)
        .json({ message: 'Incorrect email or password, please try again' });
      return;
    }

    const validPassword = await userData.checkPassword(req.body.password);

    if (!validPassword) {
      res
        .status(400)
        .json({ message: 'Incorrect email or password, please try again' });
      return;
    }

    req.session.save(() => {
      req.session.user_id = userData.id;
      req.session.logged_in = true;
      
      res.json({ user: userData, message: 'You are now logged in!' });
    });

  } catch (error) {
    res.status(400).json(error);
  }
});

router.post('/logout', (req, res) => {
  if (req.session.logged_in) {
    req.session.destroy(() => {
      res.status(204).end();
    });
  } else {
    res.status(404).end();
  }
});

module.exports = router;
