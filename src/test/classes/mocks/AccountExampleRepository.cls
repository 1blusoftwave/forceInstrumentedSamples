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
 * @description       : Account Example Repository
 * @author            : BluSoftWave
 * @group             : Repository
 * @last modified on  : 07-30-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
@SuppressWarnings('PMD.FieldNamingConventions')
public virtual inherited sharing class AccountExampleRepository extends blsw.BaseRepository  {

    ///////////////////////////////////////
    // Data Members
    ///////////////////////////////////////

    // Account name
    private final static String ACCOUNT_NAME                     = 'Account';
    // error message
    private final static String NO_DTO_FOR_ACCOUNT_ERR           = 'Need a Translator for Account to Account-DTO';

    // our fields
    @TestVisible
    private static final Set<Schema.SObjectField> ACCOUNT_FIELDS = new Set<Schema.SObjectField> {
        Account.Id
        ,Account.Name
        ,Account.OwnerId
        ,Account.Description
        ,Account.Industry
        ,Account.Phone
        ,Account.ParentId
        ,Account.Type
        ,Account.BillingAddress
    };

    ///////////////////////////////////////
    // Ctors
    ///////////////////////////////////////
    /**
     * @description AccountExampleRepository
     */
    @namespaceAccessible
    public AccountExampleRepository() {
        super(Account.SObjectType,
              ACCOUNT_FIELDS,
              (blsw.IDBManager)null);
    }
    /**
     * @description AccountExampleRepository ctor
     * @param dbMgr blsw.IDBManager
     */
    @namespaceAccessible
    public AccountExampleRepository( blsw.IDBManager dbMgr) {
        super(Account.SObjectType,
              ACCOUNT_FIELDS,
              dbMgr
              );
    }
    /**
     * @description AccountExampleRepository ctor
     * @param fields Set<Schema.SObjectField>
     * @param dbMgr blsw.IDBManager
     */
    @namespaceAccessible
    public AccountExampleRepository(Set<Schema.SObjectField> fields,
                                    blsw.IDBManager dbMgr) {
        super(Account.SObjectType,
              fields==null?ACCOUNT_FIELDS:fields,
              dbMgr);
    }

    ///////////////////////////////////////
    // Public Methods
    ///////////////////////////////////////

    /**
     * @description convert from SObject Collection
     * @param  result List<SObject>
     * @return List<blsw.EntityValue>
     */
    public override virtual List<blsw.EntityValue> convert(List<SObject> result) {
        List<blsw.EntityValue> data=null;
        // valid data, must be an 'account'
        if ( result != null && !result.isEmpty() ) {
            // is this an SObject of account name
            if ( false == ACCOUNT_NAME.equalsIgnoreCase(blsw.SObjectUtils.getSobjectName(result[0])) ) {
                // no dto defined for Account; children to determine that
                throw new blsw.BaseRepository.BaseRepositoryException(NO_DTO_FOR_ACCOUNT_ERR);
            }
        }
        /*
         * Either provide a child method, "convertFrom" to call; or, if you WILL ALWAYS convert
         * to the same DTO, then you could perform the action in "convertFrom"; but, still allow
         * children to override!
         */
        data = this.convertFrom(result);

        return data != null ? data:new  List<blsw.EntityValue>();
    }// end of convert

    //========================================================
    //+++++++++++++++ Append Fields to the Query  ++++++++++++
    //
    // The below methods are in the base class, "BaseRepository".
    //
    // They are ONLY shown here for understanding and can be
    // deleted , if not needed. The point is for awareness!!
    //
    // You can "override" the method to augment fields. I would
    // suggest your use "virtual override" so that classes that
    // inherit your Repository can "override" as well!
    //========================================================

    /**
     * @description append to Query Fields [syntactic sugar]
     * @param  fields Set<Schema.SObjectField>
     * @return AccountExampleRepository
     */
    // public virtual override AccountExampleRepository appendFields(Set<Schema.SObjectField> fields) {
    //     this.queryBuilder().selectFields(fields);
    //     return this;
    // } // end of appendFields
    /**
     * @description append to Query Fields [syntactic sugar]
     * @param  fields List<Schema.SObjectField>
     * @return AccountExampleRepository
     */
    // public  virtual override AccountExampleRepository appendFields(List<Schema.SObjectField> fields) {
    //     this.queryBuilder().selectFields(fields);
    //     return this;
    // }  // end of appendFields
    /**
     * @description append to Query Fields  [syntactic sugar]. [Does not check validity of fields]
     * @param  fields List<String>
     * @return AccountExampleRepository
     */
    // public  virtual override AccountExampleRepository appendFields(List<String> fields) {
    //     this.queryBuilder().selectFields(fields);
    //     return this;
    // } // end of appendFields
    /**
     * @description append to Query Fields  [syntactic sugar].[Does not check validity of fields]
     * @param  fields Set<String>
     * @return AccountExampleRepository
     */
    // public  virtual override AccountExampleRepository appendFields(Set<String> fields) {
    //     this.queryBuilder().selectFields(fields);
    //     return this;
    // } // end of appendFields

    ///////////////////////////////////////
    // Protected Methods
    ///////////////////////////////////////

    /**
     * @description convert From An Account SObject
     * @param  result List<Account>
     * @return List<blsw.EntityValue>
     */
    @TestVisible
    protected virtual List<blsw.EntityValue> convertFrom(List<Account> result) {
        return new  List<blsw.EntityValue>();
    } // end of convertFrom

    //========================================================
    //++++++++ Include/Exclude Fields to the Query  ++++++++++
    //
    // The below methods are in the base class, "BaseRepository".
    // These methods are for Child Classes to "override" as needed.
    // For example, you may used FieldSets based on Personas.
    // This provides the ability to exclude and include fields
    // used !!
    //
    // The below are ONLY shown here for understanding and can be
    // deleted , if not needed. The point is for awareness!!
    //
    // You can "override" the method to exclude or include fields.
    // I would suggest your use "virtual override" so that classes that
    // inherit your Repository can "override" as well!
    //========================================================


    /**
     * @description include Query Fields
     * @return Set<Schema.SObjectField>
     */
    // @TestVisible
    // protected virtual override Set<Schema.SObjectField> includeFields() {
    //     return null;
    // }     // end of includeFields
    /**
     * @description exclude Query Fields ( fields name MUST be LOWERCASE)
     * @return Set<Schema.SObjectField>
     */
    // @TestVisible
    // protected virtual override Set<Schema.SObjectField> excludeFields() {
    //     return null;
    // } // end of excludeFields


}// end of AccountExampleRepository