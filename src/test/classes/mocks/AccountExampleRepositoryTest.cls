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
 * @description       : Account Example Repository Test
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 07-31-2023
 * @last modified by  : BluSoftwave
 **/
@SuppressWarnings('PMD.OneDeclarationPerLine,PMD.VariableNamingConventions,PMD.LocalVariableNamingConventions,PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class AccountExampleRepositoryTest {
    ////////////////////////////////////////////
    // Data Members
    ////////////////////////////////////////////

    static final String PHONE_NAME                          = 'phone';
    static final String NAME_NAME                           = 'name';
    static final String OWNERID_FIELD                       = 'OwnerId';
    static final Set<Schema.SObjectField> EXCLUDED_FIELDS   = new Set<Schema.SObjectField> {
        Account.Phone,
        Account.Name
    };

    private class AccountExampleRepositoryCheck extends AccountExampleRepository {
        public AccountExampleRepositoryCheck(blsw.IDBManager dbMgr) {
            super(dbMgr);
        }
        public AccountExampleRepositoryCheck() {
            super();
        }

        public override Set<Schema.SObjectField> excludeFields() {
            return EXCLUDED_FIELDS;
        } // end of excludeFields
    }
    ////////////////////////////////////////////
    // Unit Tests
    ////////////////////////////////////////////

    @isTest
    static void excludeTest() {
        // assign
        blsw.IRepository repo = new AccountExampleRepositoryCheck();
        // act
        Set<String> excluded =  repo.queryBuilder().getFields();

        // assert

        // assert the excluded are not in the query fields
        system.assertEquals(false, excluded.contains(PHONE_NAME));
        system.assertEquals(false, excluded.contains(NAME_NAME));
    }
    @isTest
    static void ctorTest() {
        // assign / act
        blsw.IRepository repo = new AccountExampleRepository();
        // arrange
        blsw.IDBManager dbMgr = new blsw.DBManager();
        // assert

        system.assertEquals(Account.SObjectType,repo.dbManager().queryBuilder().getSObjectType());
        system.assertEquals(AccountExampleRepository.ACCOUNT_FIELDS.size(),repo.dbManager().queryBuilder().getFields().size());

        repo = new AccountExampleRepository(dbMgr);
        system.assertEquals(true,repo != null);

    }
    @SuppressWarnings('PMD.OneDeclarationPerLine')
    @isTest
    static void ctorWithDbManagerAndExcludeTest() {
        // arrange
        final blsw.Query qry = new blsw.Query(Account.sObjectType)
                               .selectFields(EXCLUDED_FIELDS)
                               .setSystemAccessLevel();
        blsw.IDBManager dbMgr               = new blsw.DBManager(qry);
        AccountExampleRepositoryCheck repo  = new AccountExampleRepositoryCheck(dbMgr);
        Integer accountFieldSize            = AccountExampleRepository.ACCOUNT_FIELDS.size(),
                EXPECTED                    = accountFieldSize - EXCLUDED_FIELDS.size();

        // assert
        system.assertEquals(Account.SObjectType,repo.dbManager().queryBuilder().getSObjectType());
        system.assertEquals(EXPECTED,repo.dbManager().queryBuilder().getFields().size());

    }

    @isTest
    static void findTest() {
        // assign / act
        final String ownerId            = UserInfo.getUserId();
        AccountExampleRepository repo   = new AccountExampleRepository();
        final Integer SIZE              = SampleTestFactory.addAccountData();
        repo.queryBuilder().setSystemAccessLevel();

        // act
        List<SObject> evalue=  (List<SObject>) repo.findByField(OWNERID_FIELD,ownerId);
        // assert
        system.assertEquals(SIZE, evalue.size());

        // assert
        for ( SObject sobj : evalue ) {
            Account acct = (Account) sobj;
            system.assertEquals(ownerId, acct.OwnerId);
            system.assertEquals(SampleTestFactory.MOCK_DESCRIPTION, acct.Description);
        }
    }
    @isTest
    static void convertTest() {
        // assign
        final List<Contact> contactList     = new List<SObject> {
            Contact.sObjectType.newSObject(null, true)
        };
        Boolean expectedExcp                = false;
        final String ownerId                = UserInfo.getUserId();
        final AccountExampleRepository repo = new AccountExampleRepository();
        SampleTestFactory.addAccountData();
        repo.queryBuilder().setSystemAccessLevel();

        List<SObject> evalue= (List<SObject>) repo.findByField(OWNERID_FIELD,ownerId);
        // act
        List<blsw.EntityValue> entityList = repo.convert(evalue);

        // assert ( this is NO conversion defined for the base Account Repo);
        system.assertEquals(0, entityList.size());

        // act
        try {
            entityList = repo.convert(contactList);
        } catch (blsw.BaseRepository.BaseRepositoryException excp) {
            expectedExcp=true;
        }
        // assert (cannot convert contact to account)
        system.assertEquals(true, expectedExcp);

    }

    @isTest
    static void getItemsTest() {
        // assign
        final AccountExampleRepository repo = new AccountExampleRepository();
        // set offset and limit
        repo.queryBuilder()
        .setOffset(1)
        .setSystemAccessLevel()
        .setLimit(1);
        SampleTestFactory.addAccountData();
        List<Account> accts= [select id from Account];
        Integer size = accts.size(),
                count=0;

        repo.queryBuilder().setSystemAccessLevel();
        while ( count < size ) {

            // assign && act
            List<Account> results = (List<Account>) repo.getItems(count,1);
            Integer sz = results.size();
            count += sz;
            // assert
            system.assertEquals(1, sz);
        }
        // asert
        system.assertEquals(count, size);

    }

}// end of AccountExampleRepositoryTest