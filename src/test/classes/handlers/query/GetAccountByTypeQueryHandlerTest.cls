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
 * @description       : GetAccountByTypeQuery Handler Test
 * @author            : BluSoftWave
 * @group             : CQRS
 * @last modified on  : 07-31-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class GetAccountByTypeQueryHandlerTest {

    ///////////////////////////////
    // Data Members
    ///////////////////////////////

    private static final String ENTERPISE_ID = 'Enterprise';

    ///////////////////////////////
    // Mock
    ///////////////////////////////
    @SuppressWarnings('sf:ConfusingTernary')
    public class GetAccountByTypeQueryHandlerMock extends GetAccountByTypeQueryHandler {

        public override blsw.IResult handle(blsw.IEntityIdentifier query) {
            return query != null ? new blsw.QueryResult() : new blsw.QueryResult(new NullPointerException());
        }
    }// end of GetAccountByTypeQueryHandlerMock

    ///////////////////////////////
    // Unit Tests
    ///////////////////////////////

    @isTest
    static void ctorTest() {
        // arrange/act/asset
        system.assertNotEquals(null, new GetAccountByTypeQueryHandlerMock());
    }

    @isTest
    static void executeTest(){
        // arrange
        blsw.QueryHandler handler = new GetAccountByTypeQueryHandler();
        blsw.IQuery query         = new GetAccountByTypeQuery(ENTERPISE_ID);
        // add data
        SampleTestFactory.addAccountData();
        // act  / assert
        system.assertNotEquals(null, handler.execute(query));

    }
    @isTest
    static void handleTest(){
        // arrange
        blsw.QueryHandler handler = new GetAccountByTypeQueryHandler();
        blsw.IQuery query         = new GetAccountByTypeQuery(ENTERPISE_ID);
        // add data
        SampleTestFactory.addAccountData();
        // act  / assert
        system.assertEquals(true, handler.handle(query).success());
        // act
        query = null;
        // act  / assert
        system.assertEquals(false, handler.handle(query).success());

    }

    @isTest
    static void  logTest(){
        // arrange
        blsw.QueryHandler handler = new GetAccountByTypeQueryHandlerMock();
        // act  / assert
        system.assertNotEquals(null,((blsw.IQueryResult) handler.handle(null)).results());
    }

}// end of GetAccountByTypeQueryHandlerTest