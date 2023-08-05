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
 * @description       : AccountTypeRecordsDTO  Test
 * @author            : BluSoftWave
 * @group             : CQRS
 * @last modified on  : 07-31-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class AccountTypeRecordsDTOTest {
    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    static final String DTO_ID      = 'Id';
    static final String DTO_NAME    = 'Name';
    static final String DTO_TYPE    = 'Type';
    static final String DTO_IND     = 'Industry';
    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////
    @isTest
    static void ctorWithParametersTest() {
        // arrange / act
        AccountTypeRecordsDTO dto = AccountTypeRecordsDTOTest.defaultValue();
        // assertions
        system.assertEquals(DTO_ID, dto.Id);
        system.assertEquals(DTO_NAME, dto.Name);
        system.assertEquals(DTO_TYPE, dto.Type);
        system.assertEquals(DTO_IND, dto.Industry);
    }
    @isTest
    static void defaultCtorTest() {
        // arrange / act
        AccountTypeRecordsDTO dto = new AccountTypeRecordsDTO();
        // assertions
        system.assertEquals(null, dto.Id);
        system.assertEquals(null, dto.Name);
        system.assertEquals(null, dto.Type);
        system.assertEquals(null, dto.Industry);
    }
    @isTest
    static void  miscMethodsTest() {
        // arrange
        Integer inx = 0;
        // act
        AccountTypeRecordsDTO dto = AccountTypeRecordsDTOTest.defaultValue();
        // assert
        system.assertEquals(AccountTypeRecordsDTO.class,dto.typeOf());
        system.assertEquals(true,dto.isTypeOf(AccountTypeRecordsDTO.class));

        // act
        for ( String key: dto.keyIndexes() ) {
            // assert
            system.assertEquals(true,dto.get(key)!=null);
        }
        // act
        Map<String,Object> result = dto.getPopulatedFieldsAsMap();
        // iterate over the map
        for ( String key : result.keySet() ) {
            // assert
            system.assertEquals(dto.get(key),result.get(key));
        }
        // iterate over the map
        for ( String key : result.keySet() ) {
            String newValue = ((String)result.get(key)) + inx;
            // act
            dto.put(key, newValue);
            // assert
            system.assertEquals(dto.get(key),newValue);
            inx++;
        }
    }

    @isTest
    static void  convertTest() {
        // act
        AccountTypeRecordsDTO dto   = new AccountTypeRecordsDTO();
        List<Account> accts         = SampleTestFactory.getAccountData();
        Integer inx                 = 0;
        // act
        List<AccountTypeRecordsDTO> entityData = (List<AccountTypeRecordsDTO>)dto.convert(accts);
        // assert
        system.assertEquals(accts.size(), entityData.size());
        for ( Account acct: accts) {
            Boolean found=false;
            inx=0;
            for (String key : dto.keyIndexes() ) {
                if ( acct.get(key) == entityData[inx].get(key) ) {
                    found=true;
                    break;
                }
                inx++;
            }
            // assert
            system.assertEquals(true,found);
        }
        //
        // Now convert from a DTO to a SObject
        //
        // act
        List<SObject> acctObjects = dto.convert(entityData);
        // assert
        system.assertEquals(acctObjects.size(), entityData.size());
        for ( SObject acct: acctObjects) {
            Boolean found=false;
            inx=0;
            for (String key : dto.keyIndexes() ) {
                if ( acct.get(key) == acctObjects[inx].get(key) ) {
                    found=true;
                    break;
                }
                inx++;
            }
            // assert
            system.assertEquals(true,found);
        }

    }

    //////////////////////////////////////////
    // Helper Methods
    //////////////////////////////////////////

    /*
     * Create Default Value
     */
    private static AccountTypeRecordsDTO defaultValue() {
        return new AccountTypeRecordsDTO(DTO_ID,
                                         DTO_NAME,
                                         DTO_TYPE,
                                         DTO_IND);
    }

}// end of AccountTypeRecordsDTOTest