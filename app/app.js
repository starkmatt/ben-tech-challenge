const app = require('express')();
const port = 8080;

app.get('/health', (req, res) => {
    res.status(200).send({
        githash: '8hd8b877d3885a50f75883faab6798d0c13726bc9cg83g#hfj',
        appname: 'ben-tech-challenge',
        version: 'v1'
    });
});

app.listen(
    port,
    () => console.log(`It's alive from ${port}`)
)