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
 * @description       : Translate JSON String to Api  Result DTO Test
 * @author            : BluSoftWave
 * @group             : Test
 * @last modified on  : 05-31-2023
 * @last modified by  : BluSoftwave
 **/
@TestVisible
@SuppressWarnings('PMD.ApexAssertionsShouldIncludeMessage,PMD.FieldNamingConventions')
@isTest(OnInstall=true isParallel=true)
private class TranslatesFromStringToFreeApiResultsTest {

    ///////////////////////////////////
    // Data Members
    ///////////////////////////////////
    static final String DATA = '{"count" : 8,"entries" :[{"API" : "AdoptAPet","Description" : "Resource to help get pets adopted","Auth" : "apiKey","HTTPS" : true,"Cors" : "yes","Link" : "https://www.adoptapet.com/public/apis/pet_list.html","Category" : "Animals"},{"API" : "Axolotl","Description" : "Collection of axolotl pictures and facts","Auth" : "","HTTPS" : true,"Cors" : "no","Link" : "https://theaxolotlapi.netlify.app/","Category" : "Animals"},{"API" : "Cat Facts","Description" : "Daily cat facts","Auth" : "","HTTPS" : true,"Cors" : "no","Link" : "https://alexwohlbruck.github.io/cat-facts/","Category" : "Animals"},{"API" : "Cataas","Description" : "Cat as a service (cats pictures and gifs)","Auth" : "","HTTPS" : true,"Cors" : "no","Link" : "https://cataas.com/","Category" : "Animals"},{"API" : "Cats","Description" : "Pictures of cats from Tumblr","Auth" : "apiKey","HTTPS" : true,"Cors" : "no","Link" : "https://docs.thecatapi.com/","Category" : "Animals"},{"API" : "Dog Facts","Description" : "Random dog facts","Auth" : "","HTTPS" : true,"Cors" : "yes","Link" : "https://dukengn.github.io/Dog-facts-API/","Category" : "Animals"},'
                               + '{"API":"Yandex.Weather","Description":"Assesses weather condition in specific locations","Auth":"apiKey","HTTPS":true,"Cors":"no","Link":"https://yandex.com/dev/weather/","Category":"Weather"}]}';
    static final String MISSING_DATA = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
    static final Integer COUNT=7;

    ///////////////////////////////////
    // Unit Tests
    ///////////////////////////////////

    @isTest
    static void translateTest() {
        // assign
        Object obj = DATA;
        TranslatesFromStringToFreeApiResults translateValue = new TranslatesFromStringToFreeApiResults();
        // act
        List<FreeApiResultsDTO> lvalue =(List<FreeApiResultsDTO>)translateValue.translate(obj);
        // assert
        system.assertEquals(false, translateValue.hasException());
        system.assertEquals(null, translateValue.mapException());
        system.assertEquals(COUNT, lvalue.size());
        for ( FreeApiResultsDTO dto: lvalue) {
            system.assertNotEquals (null, dto.API);
            system.assertNotEquals (null, dto.Description);
            system.assertNotEquals (null, dto.Auth);
            system.assertNotEquals (null, dto.HTTPS);
            system.assertNotEquals (null, dto.Cors);
            system.assertNotEquals (null, dto.Link);
            system.assertNotEquals (null, dto.Category);
        }

    }
    @isTest
    static void translateListTest() {
        // assign
        TranslatesFromStringToFreeApiResults translateValue = new TranslatesFromStringToFreeApiResults();
        List<Object> listAppl = new List<Object> {
            DATA
        };
        // act
        List<FreeApiResultsDTO> lvalue= (List<FreeApiResultsDTO>)translateValue.translate(listAppl);
        // assert
        system.assertEquals(false, translateValue.hasException());
        system.assertEquals(null, translateValue.mapException());
        system.assertEquals(COUNT, lvalue.size());
        for ( FreeApiResultsDTO dto: lvalue) {
            system.assertNotEquals (null, dto.API);
            system.assertNotEquals (null, dto.Description);
            system.assertNotEquals (null, dto.Auth);
            system.assertNotEquals (null, dto.HTTPS);
            system.assertNotEquals (null, dto.Cors);
            system.assertNotEquals (null, dto.Link);
            system.assertNotEquals (null, dto.Category);
        }
    }
    @isTest
    static void translateSetTest() {
        // assign
        TranslatesFromStringToFreeApiResults translateValue = new TranslatesFromStringToFreeApiResults();
        Set<Object> setData = new Set<Object> {
            DATA
        };
        // act
        Set<Object> lvalue=  translateValue.translate(setData);
        // assert
        system.assertEquals(false, translateValue.hasException());
        system.assertEquals(null, translateValue.mapException());
        system.assertEquals(COUNT, lvalue.size());

        for ( Object info: lvalue) {
            FreeApiResultsDTO dto = (FreeApiResultsDTO)info;
            system.assertNotEquals (null, dto.API);
            system.assertNotEquals (null, dto.Description);
            system.assertNotEquals (null, dto.Auth);
            system.assertNotEquals (null, dto.HTTPS);
            system.assertNotEquals (null, dto.Cors);
            system.assertNotEquals (null, dto.Link);
            system.assertNotEquals (null, dto.Category);
        }
    }

    @isTest
    static void translateBadDataTest() {
        // assign
        TranslatesFromStringToFreeApiResults translateValue = new TranslatesFromStringToFreeApiResults();
        Object jsonInfo= 'oh know mr bill';
        // act
        translateValue.translate(jsonInfo);
        // assert
        system.assertEquals(true, translateValue.hasException());
        system.assertNotEquals(null, translateValue.mapException());
    }

}// end of TranslatesFromStringToFreeApiResultsTest