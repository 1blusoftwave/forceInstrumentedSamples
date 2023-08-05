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
 * @description       : Data Transfer Object
 * @author            : BluSoftWave
 * @group             : DTO
 * @last modified on  : 07-28-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings('sf:ConfusingTernary,PMD.FieldNamingConventions,PMD.VariableNamingConventions')
global virtual inherited sharing class AccountTypeRecordsDTO extends blsw.BaseDTO {

    ////////////////////////////////////////
    // Data Members
    ////////////////////////////////////////

    // index names - case sensitive (lc)
    global static final String ID_NAME          = 'id';
    global static final String NAME_NAME        = 'name';
    global static final String TYPE_NAME        = 'type';
    global static final String INDUSTRY_NAME    = 'industry';

    private static final Integer MAX_ID_SIZE    = 18;

    ////////////////////////////////////////
    // Ctors
    ////////////////////////////////////////
    /**
     * @description default ctor ( for conversion)
     */
    global AccountTypeRecordsDTO() {
        this(null,null,null,null);
    }
    /*
     * Common ctor to make life easier for this sample
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    global AccountTypeRecordsDTO(String theId,
                                 String theName,
                                 String theType,
                                 String theIndustry){
        super();
        // NO Checks -- just for sample
        this.Name       = theName;
        this.Type       = theType;
        this.Industry   = theIndustry;
        this.Id         = theId;
    }
    /////////////////////////////
    // Public Properties
    /////////////////////////////
    // global fields -- UI Aware
    @AuraEnabled
    global String Id {
        get { return (String) this.get(ID_NAME); }
        set { this.put(ID_NAME,value);}
    }
    @AuraEnabled
    global String Name  {
        get { return (String) this.get(NAME_NAME); }
        set { this.put(NAME_NAME,value );}
    }
    @AuraEnabled
    global String Type {
        get { return (String) this.get(TYPE_NAME); }
        set { this.put(TYPE_NAME,value);}
    }
    @AuraEnabled
    global String Industry {
        get { return (String) this.get(INDUSTRY_NAME); }
        set { this.put(INDUSTRY_NAME,value);}
    }
    ////////////////////////////////////////
    // Public Methods
    ////////////////////////////////////////

    /**
     * @description typeOf
     * @return Type
     */
    global virtual override Type typeOf() {
        return AccountTypeRecordsDTO.class;
    }

    /**
     * @description convert , if possible
     * @param  entries List<SObject>
     * @return Collection SObjects
     */
    global virtual override List<blsw.EntityValue> convert(List<SObject> entries) {
        List<Account> accts                     = (List<Account>)entries;
        List<AccountTypeRecordsDTO> converted   = new List<AccountTypeRecordsDTO>();

        // valid data
        if ( accts != null && !accts.isEmpty() ) {
            AccountTypeRecordsDTO dto;
            Set<String> indexes = this.keyIndexes();

            // iterate over the dtos, converting
            for ( Account item : accts ) {
                dto = new AccountTypeRecordsDTO();
                for ( String key : indexes ) {
                    dto.put(key,item.get(key));
                }
                converted.add(dto);
            }
        }
        return (List<blsw.EntityValue>) converted;
    }// end of convert

    /**
     * @description convert , if possible
     * @param  entries List<EntityValue>
     * @return Collection SObjects
     */
    global virtual override List<SObject> convert(List<blsw.EntityValue> entries) {
        List<AccountTypeRecordsDTO> dtos = (List<AccountTypeRecordsDTO>)entries;
        List<Account> converted          = new List<Account>();

        // valid data
        if ( dtos != null && !dtos.isEmpty() ) {
            Account theSObject;
            Set<String> indexes = this.keyIndexes();

            // iterate over the dtos, converting
            for ( AccountTypeRecordsDTO item : dtos ) {
                theSObject = new Account();
                for ( String key : indexes) {
                    theSObject.put(key,item.get(key));
                }
                converted.add(theSObject);
            }
        }
        return (List<SObject>) converted;
    }// end of convert

}// end of AccountTypeRecordsDTO