const router = require('express').Router();
const userRoutes = require('./userRoutes');
const blogRoutes = require('./blogRoutes');
const commentRoutes = require('./comment-routes');


router.use('/comments', commentRoutes);
router.use('/users', userRoutes);
router.use('/blogs', blogRoutes);


module.exports = router;
