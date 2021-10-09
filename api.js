const express = require("express");
const fs = require("fs");

const app = express();
const port = 6120;


function checkForFile(filename) {
    const files = fs.readdirSync(`${__dirname}/files`);
    for (let i = 0; i < files.length; i++) {
        if (files[i] == `${filename}.lua`) return true;
    }
    return false;
}


app.get("/:id", (req, res) => {
    const filename = req.params.id;
    console.log(`~ Incoming request for file ${filename}.lua`);
    if (checkForFile(filename)) {
        console.log(`200 - Sending file ${filename}.lua`);
        res.status(200).sendFile(`${__dirname}/files/${filename}.lua`);
    } else {
        console.log(`404 - File ${filename}.lua could not be found`);
        res.status(404).send("File ${filename}.lua could not be found");
    }
});


app.listen(port, () => console.log(`TurtleTXT is listening on port ${port}`));