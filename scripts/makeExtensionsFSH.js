#!/usr/bin/env node

//generate FSH files from models

//if an extension is used more than once in the

let fs = require('fs');
let syncRequest = require('sync-request');

//set extensionType to fsh to generate a fsh file rather than a
//let outFolder = "/Users/davidhay/tmp/";
let outFolder = "../shorthand/";

let IGEntryType = 'http://clinfhir.com/StructureDefinition/igEntryType';
let canonicalUrl = 'http://clinfhir.com/fhir/StructureDefinition/canonicalUrl';

let nzPrefix = "http://hl7.org.nz/fhir/StructureDefinition";    //the prefix for NZ extensions...

//let remoteFhirServer = "http://home.clinfhir.com:8040/baseDstu3/";
let remoteFhirServer = "http://home.clinfhir.com:8054/baseR4/"; //the server where the models are stored


//if the url is null, then no upload
//let uploadServer = "http://home.clinfhir.com:8054/baseR4/";     //the server to upload the Extension def SD's to...
//let uploadServer = null;

//the extension from the LM where the extension url is placed...
let extensionUrl = "http://clinfhir.com/fhir/StructureDefinition/simpleExtensionUrl";

//where a copy of the ExrDef is placed
//let outFolder = "/Users/davidhay/sharedWithVB/mohProfiles/";

//let outFolder = "/Users/davidhay/Dropbox/contracting/MOH/ResourcesForIG/extensions/";


let hashValueSet = {missing:[]}   //all the valuesets in the models. missing are coded with no VS


//let arModels = ["HpiPractitionerRole"];
let arModels = [];

let options = {};
options.headers = {"accept": "application/json+fhir"}
options.timeout = 20000;        //20 seconds


//get all the models in the IG

//the implementation guide - the one on file...
//let IGPath = "/Users/davidhay/Dropbox/contracting/MOH/ResourcesForIG/nzRegistry.json";
let IGPath = "/Users/davidhay/Dropbox/contracting/MOH/ResourcesForNhipIG/nhipIG.json";
let IG = JSON.parse(fs.readFileSync(IGPath).toString());

/*
let url = remoteFhirServer + 'ImplementationGuide/cf-artifacts-nz3';
let response = syncRequest('GET', url, options);
let IG = JSON.parse(response.body.toString());

*/

//get all the models from the IG todo - need to only get LMs...
IG.definition.resource.forEach(function (item) {
    if (item.exampleCanonical) {
        //this is an example...
    } else {
        let ar = item.reference.reference.split('/');
        let id = ar[ar.length - 1]
        //console.log(id)
        arModels.push(id)
    }
});



arModels = ["HpiOrganization"];
arModels = ["HpiLocation"];
arModels = ["HpiPractitionerRole"];
arModels = ["HpiPractitioner"];

arModels = ["HpiPractitioner","NzNHIPatient"];
//arModels = ["Nzulm"];

//assume all the models are for the same IG...
let arIgEntry = [];   //a set of definition.resource entries to insert into an IG. ?todo directly update IG?

arModels.forEach(function (modelId) {
   // console.log('Examining '+modelId)
    let urlModel = remoteFhirServer + "StructureDefinition/"+modelId;
    //console.log("Load model: "+ urlModel)

    let first = true;

    let response = syncRequest('GET', urlModel, options);
    let model = JSON.parse(response.body.toString());
    let hashExtension = {};
    let currentItem;        //

    model.snapshot.element.forEach(function(ed,inx) {
        let path = ed.path;

        let description = ed.definition;

        if (ed.mapping) {
            ed.mapping.forEach(function (map) {
                if (map.map) {
                    if (map.map.indexOf('xtension') > -1 ) {
                        //this is an extension defined in the NZ ...
                        currentItem = null;     //always reset the currentItem for a new extension

                        //get the dataType
                        let dataType;
                        if (ed.type && ed.type.length > 0) {
                            dataType = ed.type[0].code;
                        }

                        //get the url
                        let ext = getSingleExtensionValue(ed,extensionUrl);
                        if (ext) {
                            let url = ext.valueString;      //the url of the extension
                            let item = {path:path, ed:[ed]} ;    //note there could be multiple ed's - ie a complex extension

                            let arPath = path.split('.');
                            if (arPath.length == 2) {

                                item.context = [{type:'element',expression:'DomainResource'}];         //means it is off the root...
                            } else {

                                item.context = [{type:'element',expression:'Element'}];         //means it can be used anywhere...
                            }

                            item.dataType = dataType;
                            item.url = url;

                            let key = path + url;
                            hashExtension[key] = item;
                            currentItem = item;     //used for complex extensions - the children will be added to it...

                        } else {
                            console.log('>>>>>>>>>>>> No extension url found for path '+path)
                        }

                    } else if (map.map[0] == '#') {
                            //yes, this is a child. Add the ED to the current one. Assume the 'child' is immediately after the 'parent'
                        if (currentItem) {      //will be null if the parent extension doesn't have a url defined...
                            currentItem.ed.push(ed);
                        }


                    }
                }

            })
        }

    });

    //console.log(JSON.stringify(hashExtension,null,2));

    for (var key in hashExtension) {
        let item = hashExtension[key]
        let url = item.url

        //only make ED's that are in NZ's domain...
        if (url.startsWith(nzPrefix))  {
            //console.log("working on "+url)

            let fsh;
            if (item.ed.length == 1) {
                //a simple extension...
                console.log("simple: "+key)
                //get the id - the last part of the url
                let ar = url.split('/');
                let id = ar[ar.length -1]

                fsh = makeSimpleExtDef(item);

                let filePath = outFolder + "extension-"+ id + '.fsh';

                fs.writeFileSync(filePath,fsh)
              //  arIgEntry.push(makeIGResource(extDef));

            } else {
                //a complex extension...
                
                console.log("complex: "+key)

                //get the id - the last part of the url
                let ar = url.split('/');
                let id = ar[ar.length -1]

                fsh = makeComplexExtDef(item);


                let filePath = outFolder + "extension-"+ id + '.fsh';
               fs.writeFileSync(filePath,fsh)
            }

        }
    }

});

//now write out the snippet for the IG
//let filePath = outFolder +'IG-snippet.json';
//fs.writeFileSync(filePath,JSON.stringify(arIgEntry,null,2))

//write out the IG
if (IG) {
   // fs.writeFileSync(IGPath,JSON.stringify(IG))
}



function makeIGResource(extDef){

    if (IG) {
        let found = false;
        let reference = "StructureDefinition/"+extDef.id;
        IG.definition.resource.forEach(entry =>{

            if (entry.reference && entry.reference.reference == reference) {
                found = true
            }
        });
        if (! found) {
            console.log('Adding to IG')
            let entry = {}
            entry.extension = [{url:IGEntryType,valueCode:'extension'},{url:canonicalUrl,valueUrl:extDef.url}]
            entry.reference = {reference:reference};
            entry.name = extDef.name;
            entry.description = extDef.id;
            IG.definition.resource.push(entry)

        }
    }




    let entry = {extension:[]};
    entry.name = extDef.name;
    entry.description = extDef.description;
    entry.reference = {reference:"StructureDefinition/"+extDef.id};
    let ext = {url:"http://clinfhir.com/StructureDefinition/canonicalUrl",valueUrl:extDef.url};
    entry.extension.push(ext);

    let extType = {url:"http://clinfhir.com/StructureDefinition/igEntryType",valueCode:'extension'};
    entry.extension.push(extType);

    return entry;

}

//generate a complex extension
function makeComplexExtDef (item) {

console.log('~~~~~~~~~~~')
    let arFsh = makeFSHHeader(item);    //get the common header info
    arFsh.push('')
    let ed = item.ed[0];        //the element definition for this

    //arFsh.push("* extension 0..0");

    let arSliceName = [];      //this will be teh contents of the 'extension contains' line...
    let posToInsert = arFsh.length;     //here is where we'll insert the 'extension contains' line...
    arFsh.push("");
    arFsh.push('// definitions of sub-extensions');

    for (var i=1; i < item.ed.length; i++) {
        let ed = item.ed[i];

        //we know there must be a mapping, or it wouldn't be in the object - this will be the slicename
        let sliceName = ed.mapping[0].map;
        sliceName = sliceName.replace(/\|/g, '');
        sliceName = sliceName.replace(/#/g, '');


        //temp fix for slicenames that sushi gets confused over (the name is already defined...)
        let arFix = ['period','code','country','type']
        if(arFix.indexOf(sliceName) > -1){
            sliceName += 'XXX'
        }


        let prefix = "* extension["+sliceName +"]";

        arSliceName.push({name:sliceName,ed:ed});        //will be added to the file at the end...


        //now add the details of each sub-extension
        if (ed.type && ed.type.length > 0) {
            console.log(ed)
            let dataType = ed.type[0].code;
            arFsh.push(prefix + ".url = \"" + sliceName + '"')
            let definition = ed.definition;
            if (definition) {
                arFsh.push(prefix + " ^definition = \"" + definition + '"')
            }




            arFsh.push(prefix + ".value[x] only " + dataType)
            //arFsh.push("* value[x] only "+ dataType)

            switch (dataType) {
                case 'CodeableConcept':
                case 'Coding':
                case 'code' :
                    //if there's a binding, then can add to fsh file
                    if (ed.binding && ed.binding.valueSet) {

                        let vs = ed.binding.valueSet;
                        let strength = ed.binding.strength;
                        let type = dataType[0].toUpperCase() + dataType.substr(1);
                        let lne = prefix + ".value" + type + " from " + vs;
                        if (strength) {
                            lne += " ("+strength+")"
                        }
                        //console.log(lne)
                        arFsh.push(lne)
                    }
                    break;

            }
            arFsh.push("");
        }

    }

    //now we can assemble the 'extension contains' line and insert...
    let lne = ""
    arFsh.splice(posToInsert,0,'* extension contains');
    arSliceName.forEach(function (slice,cnt) {
        let name = slice.name;
        let ed = slice.ed;

        posToInsert++
        console.log('-->'+name)
        let lne = "    "+name;
        lne += " " + ed.min + ".."+ed.max;
        if (cnt < arSliceName.length -1) {
            lne += " and"
        }
        arFsh.splice(posToInsert,0,lne);
    })


    console.log('~~~~~~~~~~~')
    return arFsh.join('\n')

}



//generate a simple extension
function makeSimpleExtDef (item) {

    let arFsh = makeFSHHeader(item);    //get the common header info
    arFsh.push('')
    let ed = item.ed[0];        //the element definition for this

    arFsh.push("* extension 0..0");  //means can't have further extensions...  + ed.min + ".."+ed.max);

    let type =  item.dataType[0].toUpperCase() + item.dataType.substr(1);

    arFsh.push("* value[x] only "+item.dataType)

    switch (type) {
        case 'CodeableConcept':
        case 'Coding':
        case 'code' :
            //if there's a binding, then can add to fsh file
            if (ed.binding && ed.binding.valueSet) {

                let vs = ed.binding.valueSet;
                let strength = ed.binding.strength;
                let lne = "* value" + type + " from " + vs
                if (strength) {
                    lne += " ("+strength+")"
                }
                //console.log(lne)
                arFsh.push(lne)
            }
            break;

    }

    return arFsh.join('\n')

}

function makeFSHHeader(item) {
    let arFsh = [];      //this will be the fsh file eventually...

    //get the Url for the extension
    let ed = item.ed[0];
    let ext = getSingleExtensionValue(ed,'http://clinfhir.com/fhir/StructureDefinition/simpleExtensionUrl');

    if (ext && ext.valueString) {
        //get the id - the last part of the url
        let ar = ext.valueString.split('/');
        let id = ar[ar.length -1]

        arFsh.push("Extension: " + id);
        arFsh.push("Id: " + id);
        arFsh.push('Description:  "None supplied yet"');

    }

    return arFsh;
}

function getSingleExtensionValue(resource,url) {
    //return the value of an extension assuming there is only 1...
    var extension;
    if (resource && url) {
        resource.extension = resource.extension || []
        resource.extension.forEach(function(ext){
            if (ext.url == url) {extension = ext}
        });
    }

    return extension;
}