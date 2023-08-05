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
 * @description       : Write Result Command
 * @author            : BluSoftWave
 * @group             : Sample-Commands
 * @last modified on  : 06-03-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/

@namespaceAccessible
public virtual inherited sharing class WriteResultCommand extends blsw.BaseCommand {

    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    private static final String WRITE_COMMAND_TAG   = 'CQRS-WriteResultCommand ';

    // silly id
    private String myId                             = null;

    ///////////////////////////////////
    // Ctor
    ///////////////////////////////////
    /**
     * @description WriteResultCommand defaukt ctor
     */
    @namespaceAccessible
    public WriteResultCommand() {
        super(WRITE_COMMAND_TAG);
        this.theId(UserInfo.getUserId());
    }
    /**
     * @description WriteResultCommand
     * @param  id String silly id
     */
    @namespaceAccessible
    public WriteResultCommand(String id) {
        super(WRITE_COMMAND_TAG);
        this.theId(id);
    }

    ///////////////////////////////////
    // Public Methods
    ///////////////////////////////////
    /**
     * @description componentType
     * @return Type
     */
    public virtual override Type componentType() {
        return WriteResultCommand.class;
    }// end of componentType

    /**
     * @description theId getter
     * @return   String id
     */
    public String theId() {
        return this.myId;
    }// end of theId

    /**
     * @description json Data of fields
     * @return String
     */
    public override String jsonData() {
        // get parent data
        String result = super.jsonData()
                        + ', "context" : { '
                        + '  "id" : "' + this.theId()  + '"'
                        + ' } ';

        return result;
    }// end of jsonData
    ///////////////////////////////////
    // Protected Methods
    ///////////////////////////////////
    /**
     * @description theId setter
     * @param  id string set the silly id
     */
    @Testvisible
    protected void theId(String id) {
        this.myId = id;
    }// end of theId

}// end of WriteResultCommand