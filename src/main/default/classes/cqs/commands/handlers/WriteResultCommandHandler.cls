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
 * @description       : Write Result Command Handler -silly example
 * @author            : BluSoftWave
 * @group             : Sample
 * @last modified on  : 07-29-2023
 * @last modified by  : Bill Anderson
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/

@namespaceAccessible
public virtual inherited sharing class WriteResultCommandHandler extends blsw.CommandHandler {

    ////////////////////////////////////
    // Data Members
    ////////////////////////////////////

    private static final String NULL_VALUE  = 'Null Pointer passed to "WriteResultCommandHandler"';
    private static final String ID_VALUE    = '++ WriteResultCommand.theId:';
    private static final String EXCP_VALUE  = '++ WriteResultCommand Exception:';

    ////////////////////////////////////
    // Public Methods
    ////////////////////////////////////

    /**
     * @description componentType - children SHOULD override the component type
     * @return Type class type
     */
    public virtual override Type componentType() {
        return WriteResultCommandHandler.class;
    }
    /**
     * @description handle WriteResultCommand
     * @param  command IEntityIdentifier
     * @return ICommandResult
     */
    public virtual override blsw.IResult handle(blsw.IEntityIdentifier command) {
        // note command inherits from "BaseCommand", if needed user information, etc.
        blsw.ICommandResult result = null;

        try {
            WriteResultCommand writeCommand = (WriteResultCommand)command;
            // check for null
            if ( writeCommand == null ) {
                throw new blsw.BaseQueryAndCommandHandler.BaseQueryAndCommandHandlerException(WriteResultCommandHandler.NULL_VALUE);
            }
            //=============================================================
            // tracing on?
            if ( blsw.MiscHelpers.tracerOn() ) {
                blsw.ApplicationTracer.systemLog(WriteResultCommandHandler.ID_VALUE + writeCommand.theId());
            }
            //
            // Do whatever processing is needed. Take the data from this command
            // and process it accordingly. This is where you would take the Domain
            // data and use it either to perform some task or update/insert into
            // a Sink. The base handler would have a validator, mapper, cache, unit-of-work etc.
            //
            result = new blsw.CommandResult();
        } catch (Exception excp) {
            blsw.ApplicationTracer.systemLog(System.LoggingLevel.ERROR,
                                             WriteResultCommandHandler.EXCP_VALUE + excp.getStackTraceString());
            result = new blsw.CommandResult(excp);
        }
        return result;
    } // end of handle
}// end of WriteResultCommandHandler