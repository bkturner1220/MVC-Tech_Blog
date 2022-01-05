async function commentFormHandler(event) {
    event.preventDefault();


    const comment = document.querySelector('#comment').value.trim();

    const blog_id = window.location.toString().split('/')[
        window.location.toString().split('/').length - 1
    ];

    if (comment) {
        const response = await fetch('/api/comments', {
            method: 'POST',
            body: JSON.stringify({
                comment,
                blog_id
            }),
            headers: { 'Content-Type': 'application/json' }
        });

        if (response.ok) {
            document.location.reload();
        } else {
            alert(response.statusText)
        }
    }
};

document.querySelector('.comment-form').addEventListener('submit', commentFormHandler);