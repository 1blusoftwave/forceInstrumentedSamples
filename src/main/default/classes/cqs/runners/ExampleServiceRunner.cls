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
 * @description       : Encapsulate the ApexRunner functionality
 * @author            : BluSoftWave
 * @group             : Runner
 * @last modified on  : 08-02-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@SuppressWarnings('PMD.FieldNamingConventions,PMD.ApexAssertionsShouldIncludeMessage,sf:TooManyMethods')
global virtual inherited sharing class ExampleServiceRunner extends blsw.ApexRunner {

    ///////////////////////////////////
    /// Ctors
    ///////////////////////////////////

    /**
     * @description ApexRunner default ctor ( for instantiation )
     */
    global ExampleServiceRunner() {
        super();
    }
    /**
     * @description ApexRunner
     * @param  arguments Map<String,Object>
     */
    global ExampleServiceRunner(Map<String,Object> arguments) {
        super(arguments);
    }
    ///////////////////////////////////
    /// Protected Methods (Abstract)
    ///////////////////////////////////

    /**
     * @description run Implememtation
     * @param futureArgs Object
     * @return Object
     */
    global override Object runImpl(Object futureArgs) {
        // batches up outgoing text
        List<String> outputData                 = new List<String>();
        // set the environment we want; otherwise, will default to debug in anonymous mode.
        blsw.ApexEnvironment.setEnvironment(blsw.ApexConstants.ALL_CATEGORY);
        // we turn on (whether the custom setting is on/off) various
        // attributes:
        //  (a) ensure we resolve the handler (automaticlly, if not in custom metadata)
        //  (b) event sourcing [ a means to provide state and entity information]
        //  (c) metrics of the entity
        //  (d) tracing informaton
        //  (e) caching for performance
        //  (f) place sourcing in result
        blsw.CustomSettingResourceMgr.customSetting()
        .isHandlerExtension(true)
        .isEventSourcing(true)
        .isMetrics(true)
        //.isTracing(true)
        .isCaching(true)
        .isEvaluatingPerf(true)
        ;

        //
        // get the service by name. A service name provides a means to process
        // a collection of Commands (and/or) Queries (and/or) other Services.
        // The Commands, Queries or Services are chained together to emulate a
        // process. There are control mechanisms builtin too :
        //
        //   1) Continue of failure or exit
        //   2) Pass data between items in the Pipeline
        //   3) Get Performance data (on each command/query/service) -- recommended only in Debug or Test mode
        //   4) Ensure items follow transactional behavior (i.e. rollback on failure)
        //   5) Publish events per action (Command/Query/Service)
        //
        // dispatch the service
        List<blsw.IResult> results      =  blsw.ApplicationCQRS.serviceDispatcher(new CustomerService());
        // how many results do we have
        Integer numOfResults            = results.size();

        outputData.add('Example Service Runner Result(s) Found:' + numOfResults );

        // iterate over the results
        for (Integer inx=0; inx < numOfResults; inx++ ) {

            // results
            outputData.add ((inx+1) + ') ++++++++++++++++RESULTs++++++++++++++++++++++++++++'
                            + '\nService Item Result Successful ?      :' + results[inx].success()
                            + '\nService Item Result Exception         :' + results[inx].theException()
                            + '\nService Item Result Has Exception?    :' + results[inx].hasException()
                            + '\nService Item Result Type              :' + results[inx].typeOf()
                            );
        }
        // if there were NO results ...
        if ( numOfResults==0) {
            outputData.add('Service (Tracer) Result(s) Found None' );
        }
        // dump all the output once
        blsw.ApplicationTracer.systemLog( string.join(outputData,'\n'));
        return results;

    } // end of runImpl

} // end of ExampleServiceRunner
