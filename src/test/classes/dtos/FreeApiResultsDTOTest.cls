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
 * @description       : Free Api DTO Test
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 06-03-2023
 * @last modified by  : BluSoftwave
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class FreeApiResultsDTOTest {

    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////

    @isTest
    private static void  defaultCtorTest() {
        // arrange / act
        FreeApiResultsDTO dto = new FreeApiResultsDTO();
        // assert
        system.assertEquals(FreeApiResultsDTO.class,dto.typeOf());
        system.assertEquals(null,dto.API);
        system.assertEquals(null,dto.Description);
        system.assertEquals(null,dto.Auth);
        system.assertEquals(false,dto.HTTPS);
        system.assertEquals(null,dto.Cors);
        system.assertEquals(null,dto.Link);
        system.assertEquals(null,dto.Category);

    }
    @isTest
    private static void  ctorWithArgsTest() {
        // arrange / act
        FreeApiResultsDTO dto = new FreeApiResultsDTO('api',
                                                      'descr',
                                                      'auth',
                                                      true,
                                                      'cors',
                                                      'link',
                                                      'cat'
                                                      );
        // assert
        system.assertEquals(FreeApiResultsDTO.class,dto.typeOf());
        system.assertEquals('api',dto.API);
        system.assertEquals('descr',dto.Description);
        system.assertEquals('auth',dto.Auth);
        system.assertEquals(true,dto.HTTPS);
        system.assertEquals('cors',dto.Cors);
        system.assertEquals('link',dto.Link);
        system.assertEquals('cat',dto.Category);

        // act/assert
        system.assertEquals('api',(String)dto.get(FreeApiResultsDTO.API_NAME));
        system.assertEquals('descr',(String)dto.get(FreeApiResultsDTO.DESCRIPTION_NAME));
        system.assertEquals('auth',(String)dto.get(FreeApiResultsDTO.AUTH_NAME));
        system.assertEquals(true,(Boolean)dto.get(FreeApiResultsDTO.HTTPS_NAME));
        system.assertEquals('cors',(String)dto.get(FreeApiResultsDTO.CORS_NAME));
        system.assertEquals('link',(String)dto.get(FreeApiResultsDTO.LINK_NAME));
        system.assertEquals('cat',(String)dto.get(FreeApiResultsDTO.CATEGORY_NAME));
    }

    @isTest
    private static void  putTest() {
        // arrange / act
        FreeApiResultsDTO dto = new FreeApiResultsDTO('api',
                                                      'descr',
                                                      'auth',
                                                      true,
                                                      'cors',
                                                      'link',
                                                      'cat'
                                                      );
        // act / assert
        system.assertEquals('api',(String)dto.put(FreeApiResultsDTO.API_NAME,'api'));
        system.assertEquals('descr',(String)dto.put(FreeApiResultsDTO.DESCRIPTION_NAME,'descr'));
        system.assertEquals('auth',(String)dto.put(FreeApiResultsDTO.AUTH_NAME,'auth'));
        system.assertEquals(true,(Boolean)dto.put(FreeApiResultsDTO.HTTPS_NAME,true));
        system.assertEquals('cors',(String)dto.put(FreeApiResultsDTO.CORS_NAME,'cors'));
        system.assertEquals('link',(String)dto.put(FreeApiResultsDTO.LINK_NAME,'link'));
        system.assertEquals('cat',(String)dto.put(FreeApiResultsDTO.CATEGORY_NAME,'cat'));
    }

}//end of FreeApiResultsDTOTest
