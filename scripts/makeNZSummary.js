#!/usr/bin/env node

/**
 * make the summary file use dby the NZ IG / profile viewer*/




let fs = require('fs');

let serverRoot = "http://home.clinfhir.com:8054/baseR4/"
let path = '../shorthand/build/input/resources/';       //where the files are located
let summary = {profiles:[]}     //the summary source document

//add the base resource for the graph
let baseItem = {}
baseItem.name = "Resource"
baseItem.description = "Core Resource";
summary.profiles.push(baseItem)

fs.readdirSync(path).forEach(function(file) {
    let ar = file.split('-')
    if (ar.length > 1) {

        let type = ar[0];
        if (type == 'StructureDefinition') {       //Only want structure definition

            let fullFileName = path + file;     //location of the SD file
            let contents = fs.readFileSync(fullFileName, {encoding: 'utf8'})
            let resource = JSON.parse(contents)
            if (resource.type !== "Extension") {
                console.log(fullFileName)
                let item = {}
                item.name = resource.name;
                item.description = resource.description;

                let baseProfileName = getNameFromUrl(resource.baseDefinition)
                item.baseProfile = baseProfileName
                //tem.differential = resource.differential;
                //add the differential
                /*
                if (resource.differential && resource.differential.element) {
                    let slicingPath = "";
                    //resource.differential.element.forEach(function(el){
                    for (let i=0; i < resource.differential.element.length; i++)
                    let ed = resource.differential.element(i)

                    if (slicingPath) {
                        //we are currently in a slice. If there's a sliceName then add the to the changes and continue
                        if (ed.sliceName) {
                            let change = {description : "sliced element: " + ed.sliceName}
                            change.ed = ed;
                            item.changes.push(change)
                            continue;
                        }
                    }

                    if (ed.slicing) {
                        //this is the start of a slicing sequence. set the slicingPath and continue
                        slicingPath = ed.path;
                        continue;
                    }
                    
                    //not a slicing differential

                        



                    }
                }
                */

                summary.profiles.push(item)
                if (resource.baseDefinition.indexOf("http://hl7.org/fhir/StructureDefinition/")>-1 ) {
                    //this is a core resource type. There should only be 1 level 2 profile that refers to it, so just add an item
                    let coreItem = {}
                    coreItem.name = baseProfileName
                    coreItem.description = "Core profile for "+ baseProfileName;
                    coreItem.baseProfile = "Resource"
                    summary.profiles.push(coreItem)
                }
            }
            
        }

}



})
console.log(summary)

let fileName = path + "igSummary.json"
fs.writeFileSync(fileName,JSON.stringify(summary,null,2))

function getNameFromUrl(url) {
    let ar = url.split('/')
    return ar[ar.length-1]
}
