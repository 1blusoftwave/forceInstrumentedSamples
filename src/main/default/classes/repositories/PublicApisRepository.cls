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
 * @description       : Example REST Repo for Public APIs
 * @author            : BluSoftWave
 * @group             : Repository
 * @last modified on  : 05-31-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
@SuppressWarnings('PMD.FieldNamingConventions')
public virtual inherited sharing class PublicApisRepository extends blsw.BaseRESTRepository {

    ////////////////////////////////////////////
    // Data Members
    ////////////////////////////////////////////

    // our endpoint -- domain (https ://api.publicapis.org) must be created in 'Remote Site Settings'
    private final static String RESOURCE_URL = 'https://api.publicapis.org/random';
    private final static String HTTP_GET     = 'GET';
    //++++++++++++++++++START++++++++++++++++++++++++
    // Optional ...
    //
    // headers are not needed, but shown for example
    private final static Map<String,Object> HEADER_ITEMS = new Map<String,Object> {
        'Accept'        => '*/*',
        'Content-Type'  => 'application/json'
    };
    private final static blsw.NameValuePair HEADERS = new blsw.NameValuePair(HEADER_ITEMS);
    //++++++++++++++++++END+++++++++++++++++++++++++

    ////////////////////////////////////////////
    // Ctors
    ////////////////////////////////////////////
    /**
     * @description PublicApisRepository ( default ctor, sets all the known values)
     *              Note: Do not have to use a repository like this; however, provides
     *              a common theme/process. The Handler itself could use "HttpUtility"
     *              getting the appropriate values from the "GetApiQuery" Class!
     */
    @namespaceAccessible
    public PublicApisRepository() {
        super(new blsw.HttpUtility( RESOURCE_URL, HTTP_GET, HEADERS ));
    }
}// end of PublicApisRepository
