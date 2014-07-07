'use strict';

/* Directives */
angular.module('app.directives', [])
    // taken from http://stackoverflow.com/questions/10931315/how-to-preventdefault-on-anchor-tags-in-angularjs
    .directive('holdClick', function() {
        return {
            restrict: 'A',
            link: function(scope, elem, attrs) {
                elem.on('click', function(e){
                    e.preventDefault();
                    if(attrs.ngClick){
                        scope.$eval(attrs.ngClick);
                    }
                });
            }
        };
    })
    .directive('fieldNumber', function() {
        return {
            restrict: 'A',
            link: function(scope, elem, attrs) {
                elem.on('keypress', function(e) {
                    var charCode = e.which;
                    if (charCode >= 48 && charCode <= 58)
                        return true;

                    return false;
                });

                scope.$on('$destroy', function() {
                    elem.unbind('keypress');
                });
            }
        }
    });
