define('spec/all', [
    'spec/mocks',
    'spec/utilities/test',
    'spec/utilities/deferred',
    'spec/utilities/properties'
], function(){});

window.addEventListener('load', function(){
    require('spec/all');
    jasmine.getEnv().execute()
}, false);