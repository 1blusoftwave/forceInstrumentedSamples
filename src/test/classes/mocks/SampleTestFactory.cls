/**
 * Copyright 2023-2024 BSW, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http:           //www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License .
 *
 * @author            : BluSoftWave
 * @description       : Samples Defines utilities for application testing.
 * @group             : Test
 * @last modified on  : 07-31-2023
 * @last modified by: BluSoftwave
 * Modifications Log
 * Ver Date Author Modification
 * 1.0   06-03-2023   BluSoftWave Initial Version
 *
 **/

@TestVisible
@isTest(OnInstall=true isParallel=true)
@SuppressWarnings('PMD.VariableNamingConventions,PMD.ApexAssertionsShouldIncludeMessage,PMD.LocalVariableNamingConventions,PMD.CyclomaticComplexity,PMD.StdCyclomaticComplexity')
private class SampleTestFactory {

    ////////////////////////////////////////
    // Data Members
    ////////////////////////////////////////

    // For Eventing
    @TestVisible
    private static DateTime TIMESTAMP                       =  DateTime.now();
    @TestVisible
    private static String GUID                              = MiscHelpers.newGuid();
    @TestVisible
    private static string COMMAND_ACTION                    = 'Query';
    @TestVisible
    private static string CONVERT_PAYLOAD                   = 'data { "id" : "123333"}';
    @TestVisible
    private static string CONVERT_OBJECT                    = 'testfactory';
    private static final String TID                         = 'TID:';
    @TestVisible
    private static string REQUEST_ID                        = System.Request.getCurrent().getRequestId().remove(TID);

    @TestVisible
    private static final Integer DEFAULT_NUM_OF_LOG_RECORDS = 10;
    // prefix for message field
    @TestVisible
    private static final String DEFAULT_VALUE_PREFIX        = 'PFX-';
    @TestVisible
    private static final String DEFAULT_MESG_KEY_PREFIX     = 'MSGKEY-';
    @TestVisible
    private static final String DEFAULT_APPL_NAME_PREFIX    = 'APPLNAME-';
    // overflow suffix
    @TestVisible
    private static final String DEFAULT_VALUE_OVERFLOW_SUFFIX = '-OVRFLW';
    @TestVisible
    private static final String OWNERID_VALUE               = UserInfo.getUserId();
    @TestVisible
    private static final String ADMIN_PROFILE               = 'System Administrator';
    @TestVisible
    private static final String STANDARD_PROFILE            = 'Standard User';
    @TestVisible
    private static final String OBJECT_NAME                 = blsw.ApexConstants.NAME_SPACE +'acccapplicationlog__c';
    @TestVisible
    private static final String APPL_LOG_PERMSET_LABEL      = 'BSW - Access to Accc Application Log';
    @TestVisible
    private static final String EVT_LOG_PERMSET_LABEL       = 'BSW Application Domain Program Permissions - FULL';
    @TestVisible
    private static final String EVENT_NAME                  = blsw.ApexConstants.NAME_SPACE + 'log__e';
    @TestVisible
    private static final String EVENT_SOURCE_NAME           = blsw.ApexConstants.NAME_SPACE + 'Event_Source__c';
    @TestVisible
    private static final String MOCK_DESCRIPTION            = 'mock description';
    @TestVisible
    private static final String MOCK_PHONE                  = '980-254-2800';
    @TestVisible
    private static final String MOCK_INDUSTRY               = 'Technology';
    @TestVisible
    private static final String MOCK_TYPE                   = 'Enterprise';
    @TestVisible
    private static final List<String> MOCK_ACCOUNT_NAMES    = new List<String>
    {
        'Ohana, Inc.',
        'Another, Inc.',
        'Other, Inc.'
    };
    @TestVisible
    private static final List<String> MOCK_CONTACT_NAMES    = new List<String>
    {
        'Contact Ohana, Inc.',
        'Contact Another, Inc.',
        'Contact Other, Inc.'
    };

    @TestVisible
    static Integer IdStart                                  = 1;

    /**
     * @description holds field information
     */
    @TestVisible
    private class FieldInfo {
        public String typeName;
        public String fieldName;
        public FieldInfo( String fName,String tname) {
            this.typeName=tname;
            this.fieldName=fName;
        }
    }// end of FieldInfo

    /**
     * @description fields to ignore
     */
    @TestVisible
    static final Map<String,String> FIELDS_TO_IGNORE = new Map<String,String> {
        'id'                => 'id',
        'isdeleted'         => 'isdeleted',
        'createddate'       => 'createddate',
        'createdbyid'       => 'createdbyid',
        'lastmodifieddate'  => 'lastmodifieddate',
        'lastmodifiedbyid'  => 'lastmodifiedbyid',
        'systemmodstamp'    => 'systemmodstamp'
    };

    /*
     * @description DTO -- makes it easier to shield the contents and names
     */
    @TestVisible
    @SuppressWarnings('PMD.StdCyclomaticComplexity')
    public class AcccApplicationDTO {
        @TestVisible
        String debugLevel;
        @TestVisible
        String name;
        @TestVisible
        String userException;
        @TestVisible
        String profileIdentifier;
        @TestVisible
        String refId;
        @TestVisible
        String refinfo;
        @TestVisible
        String source;
        @TestVisible
        String sourceFunction;
        @TestVisible
        String userInformation;
        @TestVisible
        String userRole;
        @TestVisible
        String ownerId;
        @TestVisible
        String message;
        @TestVisible
        String logCode;
        @TestVisible
        String payload;
        @TestVisible
        String id;
        @TestVisible
        Integer timerstamp;
        @TestVisible
        public AcccApplicationDTO(SObject input) {
            blsw__AcccApplicationLog__c item=(blsw__AcccApplicationLog__c)input;
            this.name           = string.isEmpty(item.name)?'':item.name;
            this.logCode        = string.isEmpty(item.blsw__LogCode__c)?'':item.blsw__LogCode__c;
            this.userException  = string.isEmpty(item.blsw__Exception__c)?'':item.blsw__Exception__c;
            this.ownerId        = string.isEmpty(item.OwnerId)?'':item.OwnerId;
            this.message        = string.isEmpty(item.blsw__Message__c)?'':item.blsw__Message__c;
            this.refId          = string.isEmpty(item.blsw__ReferenceId__c)?'':item.blsw__ReferenceId__c;
            this.id             = string.isEmpty(item.id)?'':item.id;
            this.source         = string.isEmpty(item.blsw__Source__c)?'':item.blsw__Source__c;
            this.userRole       = string.isEmpty(item.blsw__UserRoleId__c)?'':item.blsw__UserRoleId__c;
        }

        @TestVisible
        public SObject convert() {
            blsw__AcccApplicationLog__c log= new blsw__AcccApplicationLog__c(
                blsw__LogCode__c    =this.logCode,
                blsw__Exception__c  =this.userException,
                blsw__Message__c    =this.message,
                blsw__ReferenceId__c=this.refId,
                blsw__Source__c     =this.source,
                blsw__UserRoleId__c =this.userRole
                );
            if ( string.isNotEmpty(this.id)) {
                log.id = this.id;
            }
            return log;
        }  // end of convert

    } // end of AcccApplicationDTO

    ///////////////////////////////////
    /**
     * @description enumeration of application log category
     */
    @TestVisible
    private enum APPL_CATEGORY {
        ERROR,
        WARNING,
        INFO
    }
    ///////////////////////////////////

    /**
     * @description Field Aliases
     */
    @TestVisible
    private enum ALIAS_FIELD_NAMES {
        SOURCE_ALIAS
        ,NAME_ALIAS
        ,SOURCE_FUNCTION_ALIAS
        ,MESG_ALIAS
        ,OWNER_ALIAS
        ,TIMER_ALIAS
        ,EXCP_ALIAS
        ,REFID_ALIAS
        ,REFINFO_ALIAS
        ,ID_ALIAS
    }

    ////////////////////////////////////////
    // Utility Test Methods
    ////////////////////////////////////////


    /**
     * create a bad List<Database.SaveResult>
     * @description get a bad List<Database.SaveResult>
     * @return List<Database.SaveResult>
     */
    @TestVisible
    private static List<Database.SaveResult> getBadSaveResult() {
        NullPointerException excp = new NullPointerException();
        return new  List<Database.SaveResult> {
                   // create SaveResult exception
                   (Database.SaveResult)JSON.deserialize('{"success":false,"errors":[{"message":"'+
                                                         excp.getMessage() +
                                                         '","statusCode":"' +
                                                         System.StatusCode.INSUFFICIENT_ACCESS_OR_READONLY +
                                                         '"}]}',
                                                         Database.SaveResult.class)
        };
    }

    /**
     * @description application Contains In All
     * @param  value   Object
     * @param  alias   ALIAS_FIELD_NAMES
     * @param  objects List<SObject>
     * @return Boolean
     */
    @TestVisible
    static Boolean applicationContainsInAll(Object value,
                                            ALIAS_FIELD_NAMES alias,
                                            List<SObject> objects) {
        List<AcccApplicationDTO> items = SampleTestFactory.createAcccApplicationDTOs(objects);
        Boolean status=false;
        // any data
        if ( items.isEmpty() ) {
            return status;
        }
        /* iterate over the items */
        for ( AcccApplicationDTO item : items) {
            status = SampleTestFactory.acccDTOContains(value,item,alias);
            if ( status == false ) {
                break;
            }
        }
        return status;
    }// end of applicationContains


    /**
     * getAcccApplicationTestLogs
     * @description get test records
     * @return List<SObject>
     */
    @TestVisible
    static List<SObject> getAcccApplicationTestLogs() {
        return [SELECT Id
                , Name
                , blsw__Exception__c
                , blsw__InvocationType__c
                , blsw__LogCode__c
                , blsw__Message__c
                , blsw__ReferenceId__c
                , blsw__Source__c
                , blsw__UserRoleId__c
                , OwnerId
                FROM
                blsw__AcccApplicationLog__c
        ];
    } // end of getAcccApplicationTestLogs
      /**
       * getEventSourceTestEntries
       * @description get event source test records
       * @return List<SObject>
       */
    @TestVisible
    private static List<SObject> getEventSourceTestEntries() {
        return [SELECT Id,
                blsw__Action__c,
                blsw__Data_Type__c,
                blsw__Environment__c,
                blsw__Exception__c,
                blsw__External_Id__c,
                blsw__Message_Id__c,
                blsw__Payload__c,
                blsw__Metrics__c,
                blsw__Sequence_Number__c,
                blsw__State__c,
                blsw__Timestamp__c,
                blsw__Total_Number__c,
                blsw__TransactionId__c,
                blsw__UserId__c,
                blsw__Version__c,
                blsw__Org_Id__c,
                blsw__request_id__c,
                blsw__execution_type__c,
                blsw__misc__c,
                blsw__has_been_read__c
                FROM
                blsw__Event_Source__c
                ORDER BY blsw__Timestamp__c, blsw__Sequence_Number__c ASC
        ];
    } // end of getEventSourceTestEntries

    /**
     * getAcccApplicationLogsFromRecycleBin
     * @description get objects from recycle  records
     * @return cList<SObject>
     */
    @TestVisible
    static List<SObject> getAcccApplicationLogsFromRecycleBin() {
        return [SELECT Id
                , isDeleted
                FROM
                blsw__AcccApplicationLog__c
                WHERE
                isDeleted = true
                            all rows
        ];
    }   // end of getAcccApplicationLogsFromRecycleBin

    /**
     * @description dtoContains an item value
     * @param  value Object
     * @param  item  AcccApplicationDTO
     * @param  alias ALIAS_FIELD_NAMES
     * @return Boolean true, if contains
     */
    @SuppressWarnings('PMD.StdCyclomaticComplexity')
    @TestVisible
    static Boolean acccDTOContains(Object value, AcccApplicationDTO item, ALIAS_FIELD_NAMES alias) {
        Boolean status=false;

        /* iterate over the items */
        if ( alias == ALIAS_FIELD_NAMES.SOURCE_ALIAS ) {
            status =  item.source.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.NAME_ALIAS ) {
            status =  item.name.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.SOURCE_FUNCTION_ALIAS ) {
            status =  item.sourceFunction.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.ID_ALIAS ) {
            status =  item.id.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.MESG_ALIAS ) {
            status =  item.message.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.REFID_ALIAS ) {
            status =  item.refId.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.REFINFO_ALIAS ) {
            status =  item.refinfo.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.OWNER_ALIAS ) {
            status =  item.ownerId.contains(string.ValueOf(value));
        } else if ( alias == ALIAS_FIELD_NAMES.TIMER_ALIAS ) {
            status =  (Integer)item.timerstamp == (Integer)value;
        }

        return status;
    } // end of acccDTOContains


    ///////////////////////////////////////
    // Generic Event
    ///////////////////////////////////////
    /*
     * Create Event Value
     */
    @TestVisible
    private static blsw__BSW_Generic_Event__e createGenericEvent() {

        return SampleTestFactory.createGenericEvent(SampleTestFactory.COMMAND_ACTION,SampleTestFactory.GUID);
    }
    /*
     * Create Event Value
     */
    @TestVisible
    private static blsw__BSW_Generic_Event__e createGenericEvent(String action,String guid) {
        return new blsw__BSW_Generic_Event__e ( blsw__action__c= action,
                                                blsw__environment__c = blsw.ApexConstants.TEST_CATEGORY,
                                                blsw__exception__c ='',
                                                blsw__data_type__c=CONVERT_OBJECT,
                                                blsw__external_id__c = '',
                                                blsw__message_id__c =guid,
                                                blsw__transactionId__c =guid,
                                                blsw__sequence_number__c=1,
                                                blsw__state__c = '',
                                                blsw__total_number__c=1,
                                                blsw__payload__c = CONVERT_PAYLOAD,
                                                blsw__metrics__c = '',
                                                blsw__misc__c = '',
                                                blsw__timestamp__c = TIMESTAMP,
                                                blsw__userid__c = UserInfo.getUserId(),
                                                blsw__version__c = blsw.GenericEventDTO.GENERIC_EVENT_VERSION,
                                                blsw__request_id__c = REQUEST_ID,
                                                blsw__execution_type__c = blsw.MiscHelpers.APP_QUIDDITY_NAME,
                                                blsw__has_been_read__c = false,
                                                blsw__org_id__c = UserInfo.getOrganizationId()
                                                );
    } // end of createGenericEvent
    /*
     * Create Event Source Value
     */
    @TestVisible
    private static blsw__Event_Source__c createGenericSource(String action,String guid) {
        return new blsw__Event_Source__c ( blsw__action__c=action,
                                           blsw__environment__c = blsw.ApexConstants.TEST_CATEGORY,
                                           blsw__exception__c ='',
                                           blsw__data_type__c=CONVERT_OBJECT,
                                           blsw__external_id__c = '',
                                           blsw__message_id__c =guid,
                                           blsw__transactionId__c =guid,
                                           blsw__sequence_number__c=1,
                                           blsw__state__c = CommonEventSourceState.CommonEventState.ObjectCreated.name(),
                                           blsw__total_number__c=1,
                                           blsw__payload__c = CONVERT_PAYLOAD,
                                           blsw__metrics__c = '',
                                           blsw__misc__c = '',
                                           blsw__timestamp__c = TIMESTAMP,
                                           blsw__userid__c = UserInfo.getUserId(),
                                           blsw__version__c = blsw.GenericEventDTO.GENERIC_EVENT_VERSION,
                                           blsw__request_id__c = REQUEST_ID,
                                           blsw__execution_type__c = blsw.MiscHelpers.APP_QUIDDITY_NAME,
                                           blsw__has_been_read__c = false,
                                           blsw__org_id__c = UserInfo.getOrganizationId()
                                           );
    }
    /*
     * Create Event Source Value
     */
    @TestVisible
    private static blsw.GenericEventDTO createGenericDTOSource(String action,String guid) {
        return new blsw.GenericEventDTO( blsw.SampleTestFactory.createGenericSource(action,guid));
    }// end of createGenericDTOSource
    /*
     * Create Event Source Value
     */
    @TestVisible
    private static blsw__Event_Source__c createGenericSource() {
        return SampleTestFactory.createGenericSource(SampleTestFactory.COMMAND_ACTION,SampleTestFactory.GUID);
    }  // end of createGenericSource
    /**
     * insertApplicationTestLogs
     * @description create test records
     * @return collection of records
     */
    @TestVisible
    static void insertApplicationTestLogs(List<SObject> entries) {
        insert entries;
    }// end of insertApplicationTestLogs

    /**
     * createAcccApplicationTestLog
     * @description create test record
     * @return SObject record
     */
    @TestVisible
    static SObject createAcccApplicationTestLog(APPL_CATEGORY category) {
        return SampleTestFactory.createAcccApplicationLog(category.name(),
                                                          SampleTestFactory.OWNERID_VALUE,
                                                          SampleTestFactory.DEFAULT_VALUE_PREFIX,
                                                          SampleTestFactory.DEFAULT_VALUE_OVERFLOW_SUFFIX,
                                                          (Integer)Math.random());
    }  // end of createAcccApplicationTestLog
       /**
        * createAcccApplicationTestLogs
        * @description create test records
        * @return collection of records
        */
    @TestVisible
    static List<SObject> createAcccApplicationTestLogs(APPL_CATEGORY category) {
        return SampleTestFactory.createAcccApplicationTestLogs(SampleTestFactory.DEFAULT_NUM_OF_LOG_RECORDS,
                                                               category.name(),
                                                               SampleTestFactory.OWNERID_VALUE,
                                                               SampleTestFactory.DEFAULT_VALUE_PREFIX);
    } // end of createAcccApplicationTestLogs


    /**
     * createAcccApplicationTestLogs
     * @description create test records
     * @return collection of records
     */
    @TestVisible
    static List<SObject> createAcccApplicationTestLogs(String message) {
        final List<SObject> logs = new List<SObject>();

        for (Integer inx=0; inx< DEFAULT_NUM_OF_LOG_RECORDS; inx++) {
            String msgContext = message,
                   overflow = msgContext + DEFAULT_VALUE_OVERFLOW_SUFFIX;
            logs.add(SampleTestFactory.createAcccApplicationLog(APPL_CATEGORY.INFO.name(),
                                                                OWNERID_VALUE,
                                                                msgContext,
                                                                overflow,
                                                                inx+1));
        }
        return logs;
    } // end of createAcccApplicationTestLogs

    /**
     * createAcccApplicationTestLogs
     * @description create test records
     * @return collection of records
     */
    @TestVisible
    static List<SObject> createAcccApplicationTestLogs(integer count,
                                                       String category,
                                                       String ownerId,
                                                       String prefix) {
        final List<SObject> logs = new List<SObject>();

        for (Integer inx=0; inx< count; inx++) {
            String msgContext = prefix+inx,
                   overflow = msgContext + DEFAULT_VALUE_OVERFLOW_SUFFIX;
            logs.add(SampleTestFactory.createAcccApplicationLog(category,
                                                                ownerId,
                                                                msgContext,
                                                                overflow,
                                                                inx+1));
        }
        return logs;
    } // end of createAcccApplicationTestLogs

    /**
     * @description createAcccApplicationDTOs
     * @param  items List<SObject>
     * @return List<AcccApplicationDTO>
     */
    @TestVisible
    static List<AcccApplicationDTO> createAcccApplicationDTOs(List<SObject> items) {
        List<AcccApplicationDTO> dtos = new  List<AcccApplicationDTO>();
        List<blsw__AcccApplicationLog__c> entries = (List<blsw__AcccApplicationLog__c>)items;
        // may be null
        if ( entries != null ) {
            for ( blsw__AcccApplicationLog__c item: entries) {
                dtos.add( new AcccApplicationDTO(item));
            }
        }
        return dtos;
    }// end of createAcccApplicationDTOs

    /**
     * @description createAcccApplicationDTO
     * @param  item SObject
     * @return ApplicationDTO
     */
    @TestVisible
    static AcccApplicationDTO createAcccApplicationDTO(SObject item) {
        return new  AcccApplicationDTO((blsw__AcccApplicationLog__c)item);
    }// end of createAcccApplicationDTO

    /**
     * @description get Fake Id
     * @param  sObjType SObjectType
     * @return String
     */
    @TestVisible
    static String getFakeId(Schema.SObjectType sObjType)
    {
        String result = String.valueOf(IdStart++);
        return sObjType.getDescribe().getKeyPrefix()
               + '0'.repeat(12-result.length())
               + result;
    }// en of getFakeId

    /**
     * createAcccApplicationWithMessageLog
     * @description create test records
     * @return SObject
     */
    @TestVisible
    static SObject createAcccApplicationWithMessageLog(String message) {
        return SampleTestFactory.createAcccApplicationLog(APPL_CATEGORY.INFO.name(),
                                                          OWNERID_VALUE,
                                                          message,
                                                          message+DEFAULT_VALUE_OVERFLOW_SUFFIX,
                                                          1);
    } // end of createAcccApplicationWithMessageLog

    /**
     * createAcccApplicationLog
     * @description create test records
     * @return SObject
     */
    @TestVisible
    static SObject createAcccApplicationLog(String source,
                                            String ownerid,
                                            String message,
                                            String overflow,
                                            Integer seqId) {
        return new blsw__AcccApplicationLog__c(blsw__Source__c=source,
                                               blsw__Message__c = message,
                                               blsw__InvocationType__c = message,
                                               ownerid = ownerid);
    } // end of createAcccApplicationLog

    /**
     * @description getSObjectType of "OBJECT_NAME"
     * @return  Schema.SObjectType
     */
    @TestVisible
    static Schema.SObjectType getSObjectType() {
        return SObjectUtils.getDescribe(OBJECT_NAME).getSobjectType();
    }
    /**
     * @description getApplLogMessageField of Message__c
     * @return Schema.SobjectField
     */
    @TestVisible
    static Schema.SobjectField getApplLogMessageField() {
        return getSObjectType().getDescribe().fields.getMap().get(blsw.ApexConstants.NAME_SPACE+ 'Message__c');
    }
    ///////////////////////////////////////////////////
    // Account Helper
    ///////////////////////////////////////////////////

    /**
     * @description add Contact Data
     * @return Integer
     */
    @TestVisible
    static integer  addContactData(){
        // arrange
        List<Contact> values= getContactData();
        insert values;
        return values.size();
    } // end of addContactData
    /**
     * @description get Contact Data
     * @return List<Contact>
     */
    @TestVisible
    static List<Contact> getContactData(){
        Integer count=0;
        List<Contact> values = new List<Contact> {
            (Contact)Contact.sObjectType.newSObject(null, true),
            (Contact)Contact.sObjectType.newSObject(null, true),
            (Contact)Contact.sObjectType.newSObject(null, true)
        };
        // arrange

        values[count].LastName      =MOCK_CONTACT_NAMES[count];
        values[count].FirstName     =MOCK_CONTACT_NAMES[count];
        values[count].Description   = MOCK_DESCRIPTION;
        values[count].Phone         = MOCK_PHONE;
        values[count].OwnerId       = UserInfo.getUserId();
        count++;
        values[count].LastName      =MOCK_CONTACT_NAMES[count];
        values[count].FirstName     =MOCK_CONTACT_NAMES[count];
        values[count].Description   = MOCK_DESCRIPTION;
        values[count].Phone         = MOCK_PHONE;
        values[count].OwnerId       = UserInfo.getUserId();
        count++;
        values[count].LastName      =MOCK_CONTACT_NAMES[count];
        values[count].FirstName     =MOCK_CONTACT_NAMES[count];
        values[count].Description   = MOCK_DESCRIPTION;
        values[count].Phone         = MOCK_PHONE;
        values[count].OwnerId       = UserInfo.getUserId();

        return values;
    } // end of getContactData
    /**
     * @description add Account Data
     * @return Integer
     */
    @TestVisible
    static integer  addAccountData(){
        // arrange
        List<Account> values= getAccountData();
        insert values;
        return values.size();
    } // end of addAccountData
    /**
     * @description get Account Data
     * @return List<Account>
     */
    @TestVisible
    static List<Account> getAccountData(){
        Integer count=0;
        List<Account> values = new List<Account> {
            (Account)Account.sObjectType.newSObject(null, true),
            (Account)Account.sObjectType.newSObject(null, true),
            (Account)Account.sObjectType.newSObject(null, true)
        };
        // arrange

        values[count].Name          =MOCK_ACCOUNT_NAMES[count]; values[count].Type=MOCK_TYPE;
        values[count].Industry      =MOCK_INDUSTRY; values[count].OwnerId = UserInfo.getUserId();
        values[count].Description   = MOCK_DESCRIPTION; values[count].Phone = MOCK_PHONE;
        count++;
        values[count].Name          =MOCK_ACCOUNT_NAMES[count]; values[count].Type=MOCK_TYPE;
        values[count].Industry      =MOCK_INDUSTRY; values[count].OwnerId = UserInfo.getUserId();
        values[count].Description   = MOCK_DESCRIPTION; values[count].Phone = MOCK_PHONE;
        count++;
        values[count].Name          =MOCK_ACCOUNT_NAMES[count]; values[count].Type=MOCK_TYPE;
        values[count].Industry      =MOCK_INDUSTRY; values[count].OwnerId = UserInfo.getUserId();
        values[count].Description   = MOCK_DESCRIPTION; values[count].Phone = MOCK_PHONE;

        return values;
    } // end of getAccountData

    /**
     * @description getRequiredFields description
     * @param  sobjectName Strring
     * @return Map<String, Map<String,FieldInfo> >
     */
    @TestVisible
    private static Map<String, Map<String,FieldInfo> > getRequiredFields(String sobjectName) {
        // object list
        List<String> sObjList = new List<String> { sobjectName};
        Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(sObjList);
        Map<String, Map<String,FieldInfo> > objectRequiredFieldsMap = new Map<String, Map<String,FieldInfo> >();

        for(Schema.DescribeSObjectResult dsr : descResult) {
            Map<String,FieldInfo> requiredFields = new Map<String,FieldInfo>();
            // required fields
            Map<String, Schema.SObjectField> fieldMap = dsr.fields.getMap();
            for(String fieldname : fieldMap.keySet()) {
                Schema.DescribeFieldResult fld = fieldMap.get(fieldname).getDescribe();
                String name = fld.getName().toLowerCase();
                if(!fld.isNillable() && null != FIELDS_TO_IGNORE.get(name) ) {
                    requiredFields.put( name, new FieldInfo(name,fld.getType().name()));
                }
            }
            objectRequiredFieldsMap.put(dsr.getName(), requiredFields);
        }
        return objectRequiredFieldsMap;
    }
    //////////////////////////////////////////////////
    // Users, Profiles & Permissions
    //////////////////////////////////////////////////

    /**
     * @description set Event And Application Log Permission ; normally, none
     */
    @TestVisible
    private static User setEvtAndAppLogPermission(){
        User usr = [Select id from User where Id=: userinfo.getuserId()];
        return blsw.SampleTestFactory.setEvtAndAppLogPermission(usr);
    }// end of setEvtAndAppLogPermission

    /**
     * @description set Event And Application Log Permission ; normally, none
     */
    @TestVisible
    private static User setEvtAndAppLogPermission(User usr){

        SampleTestFactory.setObjectPermission(usr,EVENT_NAME,true,true,true);
        SampleTestFactory.setObjectPermission(usr,OBJECT_NAME,true,true,true);
        SampleTestFactory.setAcccApplicationLogPermission(usr,true,true,true);
        SampleTestFactory.setEventSourcePermission(usr,true,true,true);
        return usr;
    } // end of setEvtAndAppLogPermission

    /**
     * @description setObjectPermission
     * @param  usr        User
     * @param  objectType String
     * @param  create     Boolean
     * @param  edit       Boolean
     * @param  remove     Boolean
     */
    @TestVisible
    private static void setObjectPermission(User usr,
                                            String objectType,
                                            Boolean create,
                                            Boolean edit,
                                            Boolean remove){

        PermissionSet ps =null;
        Integer ms = DateTime.now().millisecond() * (Integer)Math.random();
        String psname = 'TestIt'
                        + ms,
               mlabel = 'Test It '
                        + ms
                        + objectType
                        + ' LogTest_'
                        + ms;
        List<PermissionSet> psList = [SELECT Id, Name FROM PermissionSet WHERE Name = :psname or Label =: mlabel ];
        if ( psList.isEmpty() ) {
            ps = new PermissionSet(Name = psname,
                                   Label = mlabel);
            insert ps;
        } else {
            ps =psList[0];
        }

        // this may already be set
        try {
            ObjectPermissions oPerm =new ObjectPermissions(ParentId = ps.Id,
                                                           PermissionsRead = true,
                                                           PermissionsCreate = create,
                                                           PermissionsEdit = edit,
                                                           PermissionsDelete = remove,
                                                           SObjectType = objectType);

            insert oPerm;
        } catch (Exception excp) {
            ApplicationTracer.systemLog( excp);
        }

        PermissionSetAssignment assignment = new PermissionSetAssignment(AssigneeId = usr.Id,
                                                                         PermissionSetId = ps.Id);
        try {
            insert assignment;
        } catch (Exception excp) {
            ApplicationTracer.systemLog( excp);
        }
    }// end of setObjectPermission
     //
     /**
      * @description setEventSourcePermission
      * @param  usr        User
      * @param  objectType String
      * @param  create     Boolean
      * @param  edit       Boolean
      * @param  remove     Boolean
      */
    @TestVisible
    private static void setEventSourcePermission(User usr,
                                                 Boolean create,
                                                 Boolean edit,
                                                 Boolean remove){

        List<PermissionSet> ps =[SELECT Id, Label, ProfileId, Profile.Name FROM PermissionSet where label = :EVT_LOG_PERMSET_LABEL];

        // this may already be set
        try {
            ObjectPermissions oPerm =new ObjectPermissions(ParentId = ps[0].Id,
                                                           PermissionsRead = true,
                                                           PermissionsCreate = create,
                                                           PermissionsEdit = edit,
                                                           PermissionsDelete = remove,
                                                           SObjectType = OBJECT_NAME);


            insert oPerm;
            // set field permissions
            SampleTestFactory.setFieldPermissionForEventSource(create,edit);
        } catch (Exception excp) {
            ApplicationTracer.systemLog( excp);
        }


        try {
            PermissionSetAssignment assignment = new PermissionSetAssignment(AssigneeId = usr.Id,
                                                                             PermissionSetId = ps[0].Id);
            insert assignment;
        } catch (Exception excp) {
            ApplicationTracer.systemLog( excp);
        }
    }  // end of setEventSourcePermission

    /**
     * @description setAcccApplicationLogPermission
     * @param  usr        User
     * @param  objectType String
     * @param  create     Boolean
     * @param  edit       Boolean
     * @param  remove     Boolean
     */
    @TestVisible
    private static void setAcccApplicationLogPermission(User usr,
                                                        Boolean create,
                                                        Boolean edit,
                                                        Boolean remove){

        List<PermissionSet> ps =[SELECT Id, Label, ProfileId, Profile.Name FROM PermissionSet where label = :APPL_LOG_PERMSET_LABEL];

        // this may already be set
        try {
            ObjectPermissions oPerm =new ObjectPermissions(ParentId = ps[0].Id,
                                                           PermissionsRead = true,
                                                           PermissionsCreate = create,
                                                           PermissionsEdit = edit,
                                                           PermissionsDelete = remove,
                                                           SObjectType = OBJECT_NAME);


            insert oPerm;
        } catch (Exception excp) {
            ApplicationTracer.systemLog( excp);
        }


        try {
            PermissionSetAssignment assignment = new PermissionSetAssignment(AssigneeId = usr.Id,
                                                                             PermissionSetId = ps[0].Id);
            insert assignment;
        } catch (Exception excp) {
            ApplicationTracer.systemLog( excp);
        }
    } // end of setAcccApplicationLogPermission
    /**
     * readonly user
     */
    @TestVisible
    private static User setTestUser(Boolean create, Boolean edit, Boolean remove){
        // may return null if either one of the profiles is NOT present ( but should be)

        final String memail='standardtestuser@mytest.com',
                     userName = memail+'.user';

        List<User> newUser = [SELECT Id,Email FROM User where email =: memail];
        if ( newUser.isEmpty() ) {
            Profile prof = SampleTestFactory.getProfile(null);
            newUser.add(new User(Alias = 'tester',
                                 Email=memail,
                                 FirstName='tester',
                                 EmailEncodingKey='UTF-8',
                                 LastName='TestingOnly',
                                 LanguageLocaleKey='en_US',
                                 LocaleSidKey='en_US',
                                 ProfileId = prof.Id,
                                 TimeZoneSidKey='America/Los_Angeles',
                                 UserName=userName)
                        );

            insert newUser;
        }

        SampleTestFactory.setObjectPermission(newUser[0],
                                              OBJECT_NAME,
                                              create,
                                              edit,
                                              remove);

        SampleTestFactory.setAcccApplicationLogPermission(newUser[0],
                                                          create,
                                                          edit,
                                                          remove);
        SampleTestFactory.setEventSourcePermission(newUser[0],
                                                   create,
                                                   edit,
                                                   remove);


        return newUser[0];
    }    // end of setTestUser

    /**
     * Set Permissions for the Event Source for Testing
     */
    @TestVisible
    private static void setFieldPermissionForEventSource(Boolean read, Boolean edit) {
        List<FieldPermissions> perms=[  SELECT Id, SobjectType, Field, PermissionsRead,PermissionsEdit FROM FieldPermissions WHERE SobjectType=:EVENT_SOURCE_NAME];
        for ( FieldPermissions fp : perms ) {
            fp.PermissionsEdit=edit;
            fp.PermissionsRead=read;
        }
        update perms;
    }// end of setFieldPermissionForEventSource
    /**
     * @description standard user
     * @return User
     */
    @TestVisible
    private static User createTestUser(String name){
        return SampleTestFactory.createTestUser(name,false);
    }
    /**
     * @description readonly user
     * @return User
     */
    @TestVisible
    private static User createTestUser(String name, Boolean adminProfile){
        // may return null if either one of the profiles is NOT present ( but should be)

        final String memail=name+'@mytest.com';

        List<User> newUser = [SELECT Id,Email FROM User where email =: memail];
        if ( newUser.isEmpty() ) {
            String profileType = adminProfile ? ADMIN_PROFILE : STANDARD_PROFILE;

            String alias = 'tuser' + Math.mod((Integer)(Math.random()*1000),3);
            Profile prof = SampleTestFactory.getProfile(profileType);

            newUser.add(new User(Alias = alias,
                                 Email=memail,
                                 EmailEncodingKey='UTF-8',
                                 LastName='TestingOnly' + adminProfile,
                                 LanguageLocaleKey='en_US',
                                 LocaleSidKey='en_US',
                                 ProfileId = prof.Id,
                                 TimeZoneSidKey='America/Los_Angeles',
                                 UserName=name+'@mytest.com.user'));

            insert newUser;
        }

        return newUser[0];
    } // end of createTestUser

    /**
     * getProfile
     * @description get a profile, ADMIN Profile, if present,
     *              fallback to Standard ( for Scratch Org)
     * @return  Profile
     */
    @TestVisible
    private static Profile getProfile(String name) {
        String profileName = name == null?ADMIN_PROFILE: name;
        /**
         * The Profile can dictate access (CRUD) If you  CHANGED the Profile from
         * 'ADMIN_PROFILE', some tests will fail !
         */
        List<Profile> prof = [SELECT Id FROM Profile WHERE Name= :profileName LIMIT 1];
        if ( prof.isEmpty() ) {
            prof = [SELECT Id FROM Profile WHERE Name= :STANDARD_PROFILE LIMIT 1];
        }
        return prof.isEmpty() ? null : prof[0];
    } // end of getProfile
}// end of SampleTestFactory