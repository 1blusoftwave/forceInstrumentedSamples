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
 * @description       : Test WriteResultCommandHandler
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class WriteResultCommandHandlerTest {

    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////
    @isTest
    static void handleMethodTest() {
        // arrange
        WriteResultCommandHandler handler   = new WriteResultCommandHandler();
        blsw.ICommand command                    = null;
        // act
        blsw.ICommandResult result               = (blsw.ICommandResult)handler.handle(command);
        // assert
        system.assertEquals(false, result.success());
        system.assertEquals(true, result.hasException());

        //+++++++++++++++++++++
        // Valid Command
        //+++++++++++++++++++++
        // arrange
        command = new WriteResultCommand();
        // act
        result = (blsw.ICommandResult)handler.handle(command);
        // assert
        system.assertEquals(true, result.success());
        system.assertEquals(false, result.hasException());
    }
}// end of WriteResultCommandHandlerTest