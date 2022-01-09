const router = require('express').Router();
const { Blog, User, Comment } = require('../../models');
const withAuth = require('../../utils/auth');

router.get('/', async (req, res) => {
  try {
    const blogData = await Blog.findAll({
      include: [
          {
              model: Comment,
              attributes: ['id', 'comment', 'blog_id', 'user_id', 'date_created'],
              include: {
                  model: User,
                  attributes: ['name']
              }
          },
          {
              model: User,
              attributes: ['name']
          }
      ]
  })
  res.json(blogData)
  } catch (error) {
    console.log(error);
          res.status(500).json(error);
  }
});

router.get('/:id', async (req, res) => {
  try {
    
    const blogData = await Blog.findOne({
      where: {
          id: req.params.id
      },
      include: [
          {
              model: Comment,
              attributes: ['id', 'comment', 'user_id', 'blog_id', 'date_created'],
              include: {
                  model: User,
                  attributes: ['name']
              }
          },
          {
              model: User,
              attributes: ['name']
          }
      ]
  })
  if (!blogData) {
    res.status(404).json({ message: 'No blog found at this id' })
}

res.json(blogData)

  } catch (error) {
    console.log(error);
    res.status(500).json(error); 
  } 
 });

router.post('/', withAuth, async (req, res) => {
  try {
    const newBlog = await Blog.create({
      ...req.body,
      user_id: req.session.user_id,
    });

    res.status(200).json(newBlog);
  } catch (error) {
    res.status(400).json(error);
  }
});

router.delete('/:id', withAuth, async (req, res) => {
  try {
    const blogData = await Blog.destroy({
      where: {
        id: req.params.id,
        user_id: req.session.user_id,
      },
    });

    if (!blogData) {
      res.status(404).json({ message: 'No blog found with this id!' });
      return;
    }

    res.status(200).json(blogData);
  } catch (error) {
    res.status(500).json(error);
  }
});

module.exports = router;
