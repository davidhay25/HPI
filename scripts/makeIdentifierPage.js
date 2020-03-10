#!/usr/bin/env node


let fs = require('fs');

let path = '../namingSystems/'; 
let outFileName = path + "identifiers.md";

let fle = []

fs.readdirSync(path).forEach(function(file) {
    let fullFileName = path + file;     //location of the fsh file
    console.log(fullFileName)
    //create a Binary resource and upload to the server
    let contents = fs.readFileSync(fullFileName, {encoding: 'utf8'})
    try {
        let resource = JSON.parse(contents)
        if (resource.resourceType == "NamingSystem") {
            let lne = "| "  + resource.description + " | ";
            resource.uniqueId.forEach(function(id){
                if  (id.type == 'uri') {
                    lne += id.value;
                }
            })
            lne += ' |'
            fle.push(lne)
        }
    } catch (ex){}
   
})
            
fs.writeFileSync(outFileName,fle.join('\r\n'))