#!/usr/bin/env node

/**
 * make the summary file use dby the NZ IG / profile viewer*/

let fs = require('fs');

let serverRoot = "http://home.clinfhir.com:8054/baseR4/"
let path = '../shorthand/build/input/resources/';       //where the files are located
let summary = {profiles:[],extensions:[]}     //the summary source document

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
                item.url = resource.url;

                let baseProfileName = getNameFromUrl(resource.baseDefinition)
                item.baseProfile = baseProfileName
                item.extensions = []
                //assemble the list of extensions
                resource.snapshot.element.forEach(function(element){
                    if (element.type) {
                        element.type.forEach(function(typ){
                            if (typ.code == "Extension") {
                                if (typ.profile) {
                                    typ.profile.forEach(function(prof){
                                        let extItem = {url:prof,path:element.path}
                                        item.extensions.push(extItem)
                                    })
                                }
                            }
                        })
                    }
                })

                summary.profiles.push(item)
                if (resource.baseDefinition.indexOf("http://hl7.org/fhir/StructureDefinition/")>-1 ) {
                    //this is a core resource type. There should only be 1 level 2 profile that refers to it, so just add an item
                    let coreItem = {}
                    coreItem.name = baseProfileName
                    coreItem.description = "Core profile for "+ baseProfileName;
                    coreItem.baseProfile = "Resource"
                    coreItem.url = "http://hl7.org/fhir/StructureDefinition/" + getNameFromUrl(resource.baseDefinition);
                    summary.profiles.push(coreItem)
                }
            } else {
                //this is an extension
                let item = {};
                item.url = resource.url;
                item.description = resource.description;
                summary.extensions.push(item)
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
