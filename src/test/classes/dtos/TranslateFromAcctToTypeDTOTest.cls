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
 * @description       : Translate Account to DTO Type Test
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 07-31-2023
 * @last modified by  : BluSoftwave
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class TranslateFromAcctToTypeDTOTest {

    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////

    @isTest
    static void translateTest() {
        // assign
        List<Account> values                        = SampleTestFactory.getAccountData();
        Object obj                                  = (Object)values[0];
        TranslateFromAcctToTypeDTO translateValue   = new TranslateFromAcctToTypeDTO();
        // act
        AccountTypeRecordsDTO lvalue                =(AccountTypeRecordsDTO)translateValue.translate(obj);
        // assert
        system.assertEquals(SampleTestFactory.MOCK_TYPE, lvalue.Type);

    }
    @isTest
    static void translateListTest() {
        // assign
        List<Account> listAppl                      = SampleTestFactory.getAccountData();
        final Integer COUNT                         = listAppl.size();
        TranslateFromAcctToTypeDTO translateValue   = new TranslateFromAcctToTypeDTO();
        // act
        List<Object> appLog= translateValue.translate(listAppl);
        // assert
        system.assertEquals(COUNT, appLog.size() );
        system.assertEquals(COUNT, listAppl.size() );
        //
        for (Integer inx =0; inx < COUNT; inx++ ) { //
            AccountTypeRecordsDTO alog  = (AccountTypeRecordsDTO)applog[inx];
            Account logVal              = (Account)listAppl[inx];
            // assert
            system.assertEquals( alog.Type, logVal.Type );
        }
    }

    @isTest
    static void translateSetTest() {
        // assign
        Set<Object> setAppl                         = TranslateFromAcctToTypeDTOTest.createSetOfAccountObjects();
        final Integer COUNT                         = setAppl.size();
        TranslateFromAcctToTypeDTO translateValue   = new TranslateFromAcctToTypeDTO();
        // act
        Set<Object> appLog                          = translateValue.translate(setAppl);
        // assert
        system.assertEquals(COUNT, appLog.size() );
        system.assertEquals(COUNT, setAppl.size() );

    }

    /////////////////////////////////////////
    // Helper Methods
    /////////////////////////////////////////
    /**
     * @description create Set of Account Objects
     * @return  Set<Object>
     */
    private static Set<Object> createSetOfAccountObjects() {
        Set<Object> setObject                       = new  Set<Object>();
        List<SObject> values                        = ( List<SObject>)SampleTestFactory.getAccountData();
        for (SObject item: values) {
            setObject.add((Object)item);
        }
        return setObject;
    }

}// end of TranslateFromAcctToTypeDTOTest