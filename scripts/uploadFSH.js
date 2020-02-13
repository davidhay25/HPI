#!/usr/bin/env node

/**
 * Upload the fsh files for profiles and extensions
 */

let IG = require("./IGUtils")
IG.loadIG('nzRegistry.json')

console.log('Uploading FSH files to [host]/Example')
let fs = require('fs');

let serverRoot = "http://home.clinfhir.com:8054/baseR4/"

let path = '../shorthand/';

fs.readdirSync(path).forEach(function(file) {
    let ar = file.split('-')
    if (ar.length > 1) {

        if (ar[0] == 'profile' || ar[0] == 'extension' || ar[0] == 'example') {       //this is a profile or an extension...
            //assume the filename format is profile-{id}.fsh with id being the id of the logical model.
            //the profile id on the server will then be the same as this filename... (incl. case)
            //get the id

            //the name is everything after the first '-'
            let type = ar[0];       // profile, extension or example
            ar.splice(0,1);
            let name = ar.join('-') ;//   ar[1]

            //remove the extension to get the id
            let ar1 = name.split('.')
            let id =  ar1[0];      
        
            let url = serverRoot + "Binary/" + type + "-" + id;  //address of the fsh Binary on the server
            
            let fullFileName = path + file;     //location of the fsh file
            
            //create a Binary resource and upload to the server
            let contents = fs.readFileSync(fullFileName, {encoding: 'utf8'})
            let resource = {resourceType:'Binary',contentType:'text/plain'}
            resource.id = type + "-" + id; //add the type (extension  or profile) to the id...
            let buff =  Buffer.from(contents);
            resource.data  = buff.toString('base64');
            IG.PUTFile(url,resource)


            //see if there is a generated SD and upload that as well. 
            //Note that the IG needs to have an extension in the entry for the logical model that references this...

            //??? use uploadResources.js for this...

            if (type == 'profile') {  // **** temp || type == 'extension') {
                let SDFileName = path + "build/input/resources/StructureDefinition-"+ id + ".json";
                try {
                    let sdContents = fs.readFileSync(SDFileName, {encoding: 'utf8'})
                    let resource = JSON.parse(sdContents)
    
                    let sdId = id+"-profile";
                    resource.id = sdId;  
                    let sdUrl = serverRoot + "StructureDefinition/"+sdId
                
                    delete resource.version             //temp - need to update server
                    resource.fhirVersion = "4.0.0"
                    IG.PUTFile(sdUrl,resource)
                } catch (ex) {
                    console.log('No StructureDefinition found - ' + SDFileName + " " + ex)
                }
            } else if (type == 'example') {
                //need to figure out the name of the generated resource
                //todo - this is actually not simple...
                 
            }
           
            



        }
}

})




//PUT a file to the server, given url and contents
function PUTFileDEP(url,resource) {

    console.log(url);
    var options = {};
    options.headers = {"content-type": "application/json+fhir"}
    options.timeout = 20000;        //20 seconds
    options.body = JSON.stringify(resource);

    var response = syncRequest('PUT', url, options);
    console.log(response.statusCode)
    if (response.statusCode !== 200 && response.statusCode !== 201) {
        console.log('  error' + response.body.toString())
        return false
    } else {
        if (response.statusCode == 200) {
            console.log('Updated ' + url)
        } 
        
        if (response.statusCode == 201) {
            console.log('Created ' + url)
        }
       
        return true
    }
}