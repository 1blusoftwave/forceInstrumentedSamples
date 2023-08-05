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
 * @description       : Data Transfer Object for Free API Results
 * @author            : BluSoftWave
 * @group             : DTO
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 * Modifications Log
 * Ver   Date         Author          Modification
 * 1.0   06-15-2023   BluSoftWave   Initial Version
 **/
@namespaceAccessible
@SuppressWarnings('sf:ConfusingTernary,PMD.FieldNamingConventions')
public inherited sharing class FreeApiResultsDTO extends blsw.BaseDTO {

    ////////////////////////////////
    // Data Members
    ////////////////////////////////


    // index names - case sensitive (lc)
    public static final String API_NAME         = 'api';
    public static final String DESCRIPTION_NAME = 'description';
    public static final String AUTH_NAME        = 'auth';
    public static final String HTTPS_NAME       = 'https';
    public static final String CORS_NAME        = 'cors';
    public static final String LINK_NAME        = 'link';
    public static final String CATEGORY_NAME    = 'category';


    ////////////////////////////////
    // Ctors
    ////////////////////////////////
    /**
     * @description default ctor ( for conversion)
     */
    @namespaceAccessible
    public FreeApiResultsDTO() {
        this(null,null,null,null,null,null,null);
    }
    /*
     * Common ctor to make life easier for this sample
     */
    @namespaceAccessible
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public FreeApiResultsDTO(String theAPI,
                             String theDescr,
                             String theAuth,
                             Boolean theHttps,
                             String theCors,
                             String theLink,
                             String theCategory){
        super();
        // NO Checks -- just for sample
        this.API            = theAPI;
        this.Description    = theDescr;
        this.Auth           = theAuth;
        this.HTTPS          = theHttps;
        this.Cors           = theCors;
        this.Link           = theLink;
        this.Category       = theCategory;

    }

    ////////////////////////////////
    // Public Properties
    ////////////////////////////////
    // public fields
    @SuppressWarnings('PMD.VariableNamingConventions')
    @AuraEnabled
    public String API {
        get { return (String)this.get(API_NAME); }
        set { this.put(API_NAME,value); }
    }
    @AuraEnabled
    @SuppressWarnings('PMD.VariableNamingConventions')
    public String Description {
        get { return (String)this.get(DESCRIPTION_NAME); }
        set { this.put(DESCRIPTION_NAME,value); }
    }
    @SuppressWarnings('PMD.VariableNamingConventions')
    @AuraEnabled
    public String Auth {
        get { return (String)this.get(AUTH_NAME); }
        set { this.put(AUTH_NAME,value); }
    }
    @SuppressWarnings('PMD.VariableNamingConventions')
    @AuraEnabled
    public Boolean HTTPS {
        get { return (Boolean)this.get(HTTPS_NAME); }
        set { this.put(HTTPS_NAME,value==null ? false: value); }
    }
    @SuppressWarnings('PMD.VariableNamingConventions')
    @AuraEnabled
    public String Cors {
        get { return (String)this.get(CORS_NAME); }
        set { this.put(CORS_NAME,value); }
    }
    @SuppressWarnings('PMD.VariableNamingConventions')
    @AuraEnabled
    public String Link {
        get { return (String)this.get(LINK_NAME); }
        set { this.put(LINK_NAME,value); }
    }
    @SuppressWarnings('PMD.VariableNamingConventions')
    @AuraEnabled
    public String Category {
        get { return (String)this.get(CATEGORY_NAME); }
        set { this.put(CATEGORY_NAME,value); }
    }
    ////////////////////////////////
    // Public Methods
    ////////////////////////////////

    /**
     * @description typeOf
     * @return Type
     */
    public virtual override Type typeOf() {
        return FreeApiResultsDTO.class;
    }
}// end of FreeApiResultsDTO