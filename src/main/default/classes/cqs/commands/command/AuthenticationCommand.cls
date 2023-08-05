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
 * @description       : Authenticate Command
 * @author            : BluSoftWave
 * @group             : Sample-Commands
 * @last modified on  : 07-28-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
public virtual inherited sharing class AuthenticationCommand extends blsw.BaseCommand {

    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    private static final String AUTH_COMMAND_TAG = 'CQRS-AuthenticationCommand ';

    // the password
    private String thePassword;
    // the user information
    private String userInformation;

    ///////////////////////////////////
    // Ctors
    ///////////////////////////////////
    /**
     * @description AuthenticationCommand (default ctor)
     */
    @namespaceAccessible
    public AuthenticationCommand( ) {
        super(AUTH_COMMAND_TAG);

        this.userId(UserInfo.getUserId());
        // made up ; just pushing data
        this.password(UserInfo.getProfileId());
    }
    /**
     * @description AuthenticationCommand
     * @param  userName String
     * @param  pwd   String
     */
    @namespaceAccessible
    public AuthenticationCommand(String userName, String pwd) {
        super(AUTH_COMMAND_TAG);

        this.userId(userName);
        this.password(pwd);
    }

    ///////////////////////////////////
    // Public Methods
    ///////////////////////////////////
    /**
     * @description userId
     * @return String user-id
     */
    public String userId() {
        return this.userInformation;
    }
    /**
     * @description password
     * @return   return password
     */
    public String password() {
        return this.thePassword;
    }
    /**
     * @description componentType
     * @return  Type
     */
    public override Type componentType() {
        return AuthenticationCommand.class;
    }
    /**
     * @description json Data of fields
     * @return String
     */
    public override String jsonData() {
        // get parent data
        String result = super.jsonData();
        blsw.StringBuilder sb= new blsw.StringBuilder (result);
        // not invoking JSON.deserialize
        return sb.append(', ' + blsw.ApplicationDomain.PERF_PARAMS_JSON_TAG + ' : { ')
               .append('  "userid" : "').append (this.userid()).append( '",')
               .append('  "pwd" : "').append(this.password()).append('"')
               .append(' } ')
               .toString();
    } // end of jsonData
    ///////////////////////////////////
    // Protected
    ///////////////////////////////////
    /**
     * @description password setter
     * @param  pwd String
     */
    @Testvisible
    protected void password(String pwd) {
        this.thePassword=pwd;
    }
    /**
     * @description userId setter
     * @param  id silly string id
     */
    @Testvisible
    protected void userId(String id) {
        this.userInformation=id;
    }
} // end of AuthenticationCommand