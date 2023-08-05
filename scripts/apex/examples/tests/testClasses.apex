List<List<SObject> > testClasses = [FIND '@isTest' IN ALL FIELDS RETURNING ApexClass(Id, Name)];

For (SObject atest: testClasses[0]){
    system.debug('>' + ((ApexClass)atest).Name);
}