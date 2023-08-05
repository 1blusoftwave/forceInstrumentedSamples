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
 * @description       : Test Example Service Runner
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 06-03-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-03-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class ExampleServiceRunnerTest {

    ///////////////////////////////////////
    // Unit Tests
    ///////////////////////////////////////
    @isTest
    static void runTest() {
        // assign
        ExampleServiceRunner esr    = new ExampleServiceRunner();
        List<blsw.IResult> results  = (List<blsw.IResult>)esr.run();
        // assert
        Integer numOfResults        = results.size();

        // iterate over the results
        for (Integer inx=0; inx < numOfResults; inx++ ) {
            // results
            system.assertEquals(true,  results[inx].success());
            system.assertEquals(null,results[inx].theException());
            system.assertEquals(false,results[inx].hasException());

        }
    }

}// end of ExampleServiceRunnerTest