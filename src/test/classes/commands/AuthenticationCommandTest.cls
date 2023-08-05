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
 * @description       : Test Authenticate Command Sample
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 06-03-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class AuthenticationCommandTest {

    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    static final String UID = 'uid';
    static final String PWD = 'pwd';
    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////
    @isTest
    static void ctorTest() {
        // arrange / act
        AuthenticationCommand command = new AuthenticationCommand(UID,PWD);
        // assert
        system.assertEquals(UID, command.userId());
        system.assertEquals(PWD, command.password());

    }

    @isTest
    static void getterSetterTest() {
        // arrange
        final String EXPECTED_UID           = UID + '1';
        final String EXPECTED_PWD           = PWD + '1';
        final AuthenticationCommand command = new AuthenticationCommand(UID,PWD);
        // assert
        system.assertEquals(UID, command.userId());
        system.assertEquals(PWD, command.password());
        // act
        command.userId(EXPECTED_UID);
        command.password(EXPECTED_PWD);
        // assert
        system.assertEquals(EXPECTED_UID, command.userId());
        system.assertEquals(EXPECTED_PWD, command.password());

    }
} // end of AuthenticationCommand