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
 * @description       : Translator from Account to blsw.AccountTypeRecordsDTO
 * @author            : BluSoftWave
 * @group             : Data
 * @last modified on  : 07-27-2023
 * @last modified by  : BluSoftwave
 **/
@namespaceAccessible
@SuppressWarnings('sf:ConfusingTernary,PMD.FieldNamingConventions')
public virtual inherited sharing class TranslateFromAcctToTypeDTO extends blsw.BaseMapTranslator {

    ///////////////////////////////////////
    // Public Methods
    ///////////////////////////////////////

    /**
     * @description translate from a single value
     * @param  fromData Object
     * @return Object
     */
    public override Object translate(Object fromData){
        Account acct = (Account)fromData;
        Object result =null;
        if ( acct != null) {
            result= this.fromAccount(acct);
        }
        return result;
    }// end of translate
    /**
     * @description translate from a collection (list) value
     * @param  fromType List<Object>
     * @return List<Object>
     */
    public override List<Object> translate(List<Object> fromType){

        List<Object> result =null;
        if ( fromType != null && !fromType.isEmpty()) {
            List<Account> items = this.fromListObjectToListSO(fromType);
            result= this.fromAccount(items);
        }
        return result== null ? new List<Object>() : result;
    }// end of translate
    /**
     * @description translate from a collection (set) value
     * @param  fromType fromType Set<Object>
     * @return Set<Object>
     */
    public override Set<Object> translate(Set<Object> fromType){

        Set<Object> result =null;
        if ( fromType != null && !fromType.isEmpty()) {
            Set<Account> setOfAccts = this.fromSetToSet(fromType);
            // this should work!!! ( as it does for list above!)
            // result= this.fromAccount(setOfAccts);
            Set<AccountTypeRecordsDTO> items = this.fromAccount(setOfAccts);
            result = this.convertToSet(items);
        }
        return result==null?new Set<Object>(): result;
    }// end of translate

    ///////////////////////////////////////
    // Private Methods
    ///////////////////////////////////////

    /**
     * @description convert Set<> to Set<Object> as Apex does not allow
     * a simple new Set<Object>(List<...>) nor any casting!
     * @param  items Set<Object>
     * @return Set<Object>
     */
    @TestVisible
    protected virtual Set<Object> convertToSet(Set<AccountTypeRecordsDTO> items) {
        Set<Object> result=new  Set<Object>();
        for ( AccountTypeRecordsDTO aobj : items) {
            result.add(aobj);
        }
        return result;
    } // end of convertToSet
    /**
     * @description convert Set<Object> to a List as Apex does not allow
     * a simple new Set<Object>(List<...>) nor any casting!
     * @param  fromType Set<Object>
     * @return List<Account>
     */
    private List<Account> fromSetToList(Set<Object> fromType) {
        List<Account> items = new  List<Account>();
        for ( Object obj : fromType) {
            items.add( (Account)obj);
        }
        return items;
    }  // end of fromSetToList
    /**
     * @description convert Set<Object> to a List as Apex does not allow
     * a simple new Set<Object>(List<...>) nor any casting!
     * @param  fromType Set<Object>
     * @return List<Account>
     */
    private Set<Account> fromSetToSet(Set<Object> fromType) {
        Set<Account> items = new  Set<Account>();
        for ( Object obj : fromType) {
            items.add( (Account)obj);
        }
        return items;
    }   // end of fromSetToSet
    /**
     * @description cannot cast to List<Account>; thus have to iterate over
     * the list!! ARGH!!
     * @param  items List<Object>
     * @return List<Account>
     */
    private List<Account> fromListObjectToListSO(List<Object> items) {
        List<Account> objects= new  List<Account>();
        for ( Object item : items) {
            objects.add((Account)item);
        }
        return objects;
    } // end of fromListObjectToListSO

    /**
     * @description from Account to AccountTypeRecordsDTO
     * @param  item Account
     * @return AccountTypeRecordsDTO
     */
    private AccountTypeRecordsDTO fromAccount(Account item) {

        // use 'getItem' that way if the item is NOT set, we get a null!
        return new AccountTypeRecordsDTO((String) super.getItem(item,AccountTypeRecordsDTO.ID_NAME)
                                         ,(String) super.getItem(item,AccountTypeRecordsDTO.NAME_NAME)
                                         ,(String) super.getItem(item,AccountTypeRecordsDTO.TYPE_NAME)
                                         ,(String) super.getItem(item,AccountTypeRecordsDTO.INDUSTRY_NAME));

    }// end of fromAccount

    /**
     * @description from List<Account> to  List<AccountTypeRecordsDTO>
     * @param  items List<Account>
     * @return  List<AccountTypeRecordsDTO>
     */
    private List<AccountTypeRecordsDTO> fromAccount(List<Account> items) {
        List<AccountTypeRecordsDTO> listOf = new List<AccountTypeRecordsDTO>();
        for ( Account item: items) {
            listOf.add(this.fromAccount(item));
        }
        return listOf;
    }// end of fromAccount

    /**
     * @description from List<Account> to  List<AccountTypeRecordsDTO>
     * @param  items List<Account>
     * @return  List<AccountTypeRecordsDTO>
     */
    private Set<AccountTypeRecordsDTO> fromAccount(Set<Account> items) {
        Set<AccountTypeRecordsDTO> setOf = new Set<AccountTypeRecordsDTO>();
        for ( Account item: items) {
            setOf.add(this.fromAccount(item));
        }
        return setOf;
    }  // end of fromAccount
}// end of TranslateFromAcctToTypeDTO