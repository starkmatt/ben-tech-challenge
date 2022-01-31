const app = require('express')();
const port = process.env.PORT;

app.get('/health', (req, res) => {
    res.status(200).send({
        githash: process.env.SHA,
        appname: process.env.APPNAME,
        version: process.env.VERSION
    });
});

app.listen(
    port,
    () => console.log(`It's alive from ${port}`)
)