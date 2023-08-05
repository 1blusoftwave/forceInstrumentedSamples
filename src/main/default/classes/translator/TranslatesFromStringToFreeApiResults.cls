/**
 * Copyright 2023-2024 BSW, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http:       //www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License .
 *
 * @description       : Translate String to List of API Entries
 *                      Originally created by JSON2Apex http ://json2apex.herokuapp.com/
 *                      [Heavily modified];
 *                      supports interpreting : (https://api.publicapis.org)
 *                      must be created in 'Remote Site Settings'
 *
 * @author            : BluSoftWave
 * @group             : Translator
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 **/

public virtual inherited sharing class TranslatesFromStringToFreeApiResults extends blsw.BaseMapTranslator {

    /**
     * Entries from the Parsed JSON String
     */
    @SuppressWarnings('PMD.VariableNamingConventions')
    private class Entries {
        public String API {get; set;}
        public String Description {get; set;}
        public String Auth {get; set;}
        public Boolean HTTPS {get; set;}
        public String Cors {get; set;}
        public String Link {get; set;}
        public String Category {get; set;}

        @SuppressWarnings('PMD.CognitiveComplexity,PMD.NcssConstructorCount')
        public Entries(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'API') {
                            API = parser.getText();
                        } else if (text == 'Description') {
                            Description = parser.getText();
                        } else if (text == 'Auth') {
                            Auth = parser.getText();
                        } else if (text == 'HTTPS') {
                            HTTPS = parser.getBooleanValue();
                        } else if (text == 'Cors') {
                            Cors = parser.getText();
                        } else if (text == 'Link') {
                            Link = parser.getText();
                        } else if (text == 'Category') {
                            Category = parser.getText();
                        } else {
                            blsw.ApplicationTracer.systemLog(LoggingLevel.WARN,
                                                             'Entries consuming unrecognized property: '+text);
                            TranslatesFromStringToFreeApiResults.consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    /**
     * @description translate from a single value
     * @param  fromData Object
     * @return Object
     */
    public override Object translate(Object fromData){
        String data = (String)fromData;
        Object result =null;
        // reset the information as a previous call
        // may have had a exception
        super.reset();
        // any work
        if ( data != null) {
            result= this.fromString(data);
        }
        return result;
    }// end of translate
    /**
     * @description translate from a collection (list) value
     * @param  fromType List<Object>
     * @return List<Object>
     */
    public override List<Object> translate(List<Object> fromType){

        List<Object> result =null;
        // reset the information as a previous call
        // may have had a exception
        super.reset();
        // validate collection
        if ( this.validCollection(fromType) ) {
            result = this.fromListObjectToList(fromType);
        }
        return result;
    }// end of translate
    /**
     * @description translate from a collection (set) value
     * @param  fromType fromType Set<Object>
     * @return Set<Object>
     */
    public override Set<Object> translate(Set<Object> fromType){

        Set<Object> result =null;
        // reset the information as a previous call
        // may have had a exception
        super.reset();
        // validate collection
        if ( this.validCollection(fromType) ) {
            List<FreeApiResultsDTO> listOfEntries = ( List<FreeApiResultsDTO>)this.fromSetToList(fromType);
            result= this.convertFromListToSet(listOfEntries);
        }
        return result;
    }// end of translate

    //////////////////////////////////////
    // Private Methods
    //////////////////////////////////////

    /**
     * @description valid List
     * @param  items List<Object>
     * @return Boolean true, if valid
     */
    private Boolean validCollection(List<Object> items) {
        return items != null && !items.isEmpty();
    }// end of validCollection
    /**
     * @description valid Set
     * @param  items Set<Object>
     * @return Boolean true, if valid
     */
    private Boolean validCollection(Set<Object> items) {
        return items != null && !items.isEmpty();
    } // end of validCollection
    /**
     * @description convert Set<Object> to a List as Apex does not allow
     * a simple new Set<Object>(List<...>) nor any casting!
     * @param  fromType Set<Object>
     * @return List<FreeApiResultsDTO>
     */
    private List<FreeApiResultsDTO> fromSetToList(Set<Object> fromType) {
        List<FreeApiResultsDTO> items = new  List<FreeApiResultsDTO>();
        List<FreeApiResultsDTO> values;
        for ( Object obj : fromType) {
            values = this.fromString((String)obj);
            // any data
            if ( values != null && !values.isEmpty() ) {
                items.addAll(values);
            }
        }
        return items;
    }  // end of fromSetToList
    /**
     * @description cannot cast to List<FreeApiResultsDTO>; thus have to iterate over
     * the list!! ARGH!!
     * @param  items List<Object>
     * @return List<FreeApiResultsDTO>
     */
    private List<FreeApiResultsDTO> fromListObjectToList(List<Object> items) {
        List<FreeApiResultsDTO> objects= new  List<FreeApiResultsDTO>();
        List<FreeApiResultsDTO> values;
        for ( Object item : items) {
            values = this.fromString((String)item);
            if ( values != null && !values.isEmpty() ) {
                objects.addAll(values);
            }
        }

        return objects;
    } // end of fromListObjectToList

    /**
     * @description from String to List<FreeApiResultsDTO>
     * @param  item FreeApiResultsDTO
     * @return FreeApiResultsDTO
     */
    private List<FreeApiResultsDTO> fromString(String item) {
        List<FreeApiResultsDTO> result = null;
        try{
            result= TranslatesFromStringToFreeApiResults.parse(item);
        } catch (Exception excp) {
            super.mapException(excp);
        }
        return result==null ? new List<FreeApiResultsDTO>(): result;
    }// end of fromString

    /**
     * @description parse
     * @param  json String
     * @return List<FreeApiResultsDTO>
     */
    private static List<FreeApiResultsDTO> parse(String json) {

        System.JSONParser parser = System.JSON.createParser(json);
        return TranslatesFromStringToFreeApiResults.parse(parser);

    }// end of parse
    /**
     * @description JSON parser
     * @param  parser JSONParser
     * @return List<FreeApiResultsDTO>
     */
    private static List<FreeApiResultsDTO> parse(JSONParser parser) {
        Integer count=0;
        List<FreeApiResultsDTO> entries=null;

        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'count') {
                        count = parser.getIntegerValue();
                    } else if (text == 'entries') {
                        entries = TranslatesFromStringToFreeApiResults.arrayOfEntries(parser);
                        break;
                    } else {
                        System.debug(LoggingLevel.WARN, 'TranslatesFromStringToFreeApiResults consuming unrecognized property: '+text);
                        TranslatesFromStringToFreeApiResults.consumeObject(parser);
                    }
                }
            }
        }
        return entries==null? new List<FreeApiResultsDTO>(): entries;
    }// end of parse

    /**
     * @description consumeObject
     * @param  parser System.JSONParser
     */
    private static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT ||
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                       curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }    // end of consumeObject

    /**
     * @description array Of Entries from the parser
     * @param  jparse System.JSONParser
     * @return List<FreeApiResultsDTO>
     */
    private static List<FreeApiResultsDTO> arrayOfEntries(System.JSONParser jparse) {
        List<FreeApiResultsDTO> res = new List<FreeApiResultsDTO>();
        if (jparse.getCurrentToken() == null) {
            jparse.nextToken();
        }
        Entries entry;
        while (jparse.nextToken() != System.JSONToken.END_ARRAY) {
            // This is ONLY an example ... but ...
            // REfactor! this is 2*O(n)!!!
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            entry= new Entries(jparse);
            res.add(new FreeApiResultsDTO(entry.API,
                                          entry.Description,
                                          entry.Auth,
                                          entry.HTTPS,
                                          entry.Cors,
                                          entry.Link,
                                          entry.Category ));
        }
        return res;
    }// end of arrayOfEntries

}// end of TranslatesFromStringToFreeApiResults