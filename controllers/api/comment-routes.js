const router = require('express').Router();
const { Comment, User, Blog } = require('../../models');
const withAuth = require('../../utils/auth');

router.get('/', async (req, res) => {
    try {
        const commentData = await Comment.findAll()
        res.json(commentData)
    } catch (err) {
        console.log(err);
        res.status(500).json(err);
    }

        });


router.post('/', withAuth, async (req, res) => {
    try {
      const commentData = await Comment.create({
            comment: req.body.comment,
            user_id: req.session.user_id,
            blog_id: req.body.blog_id
        })
        res.json(commentData)
    } catch (err) {
        console.log(err);
        res.status(400).json(err);
    }   
});


module.exports = router;