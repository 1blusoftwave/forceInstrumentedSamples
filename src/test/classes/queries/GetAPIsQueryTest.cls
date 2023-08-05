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
 * @description       : GetAPIsQuery Test
 * @author            : BluSoftWave
 * @group             : CQRS
 * @last modified on  : 06-03-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class GetAPIsQueryTest {
    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////

    private static final String API_CALLOUT = 'https://api.publicapis.org/list';
    private static final String HTTPMETHOD  = 'PATCH';
    private static final String PERF_TAG    = 'test';


    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////

    @isTest
    static void ctorAndMethodWithoutValueTest() {
        // arrange/act
        GetAPIsQuery query = new GetAPIsQuery();
        // assert
        system.assertNotEquals(null, query);
        system.assertEquals(GetAPIsQuery.API_CALLOUT, query.theEndpoint());
        system.assertEquals(GetAPIsQuery.API_QUERY_TAG, query.performanceTag());
        system.assertEquals(GetAPIsQuery.HTTP_ACTION, query.httpAction());
        system.assertEquals(query.jsonData(), query.toString());
        system.assertEquals(GetAPIsQuery.class, query.componentType());

    }
    @isTest
    static void ctorAndMethodWithValueTest() {
        // arrange/act
        GetAPIsQuery query = new GetAPIsQuery(API_CALLOUT,HTTPMETHOD);
        // assert
        system.assertNotEquals(null, query);
        system.assertEquals(API_CALLOUT, query.theEndpoint());
        system.assertEquals(GetAPIsQuery.API_QUERY_TAG, query.performanceTag());
        system.assertEquals(HTTPMETHOD, query.httpAction());
        system.assertEquals(null, query.toType());
        // act
        query = new GetAPIsQuery(API_CALLOUT);
        // assert
        system.assertEquals(API_CALLOUT, query.theEndpoint());
    }
    @isTest
    static void ctorWithArgumentsTest() {
        // arrange/act

        GetAPIsQuery query = new GetAPIsQuery(API_CALLOUT,HTTPMETHOD,Account.class,PERF_TAG);
        // assert
        system.assertNotEquals(null, query);
        system.assertEquals(API_CALLOUT, query.theEndpoint());
        system.assertEquals(PERF_TAG, query.performanceTag());
        system.assertEquals(HTTPMETHOD, query.httpAction());
        system.assertEquals(Account.class, query.toType());
    }
    @isTest
    static void settersTest() {
        // arrange/act

        GetAPIsQuery query = new GetAPIsQuery();
        // assert
        system.assertNotEquals(null, query);

        // act
        query.theEndpoint(API_CALLOUT);
        // assert
        system.assertEquals(API_CALLOUT, query.theEndpoint());

        // act
        query.performanceTag(PERF_TAG);
        // assert
        system.assertEquals(PERF_TAG, query.performanceTag());

        // act
        query.httpAction(HTTPMETHOD);
        // assert
        system.assertEquals(HTTPMETHOD, query.httpAction());

    }
}// end of GetAPIsQueryTest