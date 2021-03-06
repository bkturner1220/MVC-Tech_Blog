const router = require('express').Router();
const { Blog, User, Comment } = require('../models');
const withAuth = require('../utils/auth');

router.get('/', async (req, res) => {
  try {
    // Get all blogs and JOIN with user data
    const blogData = await Blog.findAll({
      order: [['date_created', 'DESC']],
      
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
console.log(blogData)
    // Serialize data so the template can read it
    const blogs = blogData.map((blog) => blog.get({ plain: true }));
console.log(blogs)
    // Pass serialized data and session flag into template
    res.render('homepage', { 
      blogs, 
      logged_in: req.session.logged_in 
    });
  } catch (error) {
    console.log(error)
    res.status(500).json(error);
  }
});

router.get('/blog/:id', async (req, res) => {
  try {
    const blogData = await Blog.findByPk(req.params.id, {
      where: {
        id: req.params.id
    },
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

    const blog = blogData.get({ plain: true });

    res.render('blogs', {
      ...blog,
      logged_in: req.session.logged_in
    });
  } catch (error) {
    res.status(500).json(error);
  }
});

// Use withAuth middleware to prevent access to route
router.get('/dashboard', withAuth, async (req, res) => {
  try {
    // Find the logged in user based on the session ID
    const userData = await User.findByPk(req.session.user_id, {
      attributes: { exclude: ['password'] },
      include: [{ model: Blog }],
    });

    const user = userData.get({ plain: true });

    res.render('dashboard', {
      ...user,
      logged_in: true
    });
  } catch (error) {
    res.status(500).json(error);
  }
});

router.get('/login', (req, res) => {
  // If the user is already logged in, redirect the request to another route
  if (req.session.logged_in) {
    res.redirect('/dashboard');
    return;
  }

  res.render('login');
});

router.get('/signup', (req, res) => {
  // If the user is already logged in, redirect the request to another route
  if (req.session.logged_in) {
    res.redirect('/dashboard');
    return;
  }

  res.render('signup');
});


module.exports = router;