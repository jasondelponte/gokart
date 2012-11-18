/**
 * Builds a module loader tool which will resolve dependencies.
 */
(function requireModule(context) {
	var modules = {};

    /**
     *
     * @param {String} name
     * @return {Object}
     *
     * @function
     */
	context.require = function requireFunc(name) {
		var mod = modules[name];
		if (!mod) {
			console.error('Module '+name+' was not defined');
			return null;
		}

        if (mod.built) {
            return mod.exports;
        }

        var dependencies = mod.dependencies,
            numDep = dependencies.length;
        var builtDep = [];
        for (var i = 0; i < numDep; i++) {
            var dep = dependencies[i];
            builtDep.push(requireFunc(dep));
        }
        if (mod.builder) {
            mod.exports = mod.builder.apply(null, builtDep);
        }
        mod.built = true;

        return mod.exports;
	};

    /**
     * Adds a new module to the list of known modules.  It will not be compiled yet until
     * it is required. Unless the execute flag is set in the options.
     *
     * @param {String} name name of this module
     * @param {String[]} dep list of dependency names
     * @param {function} builder function taking a list of built dependencies
     * @param options optional parameters to configure the require (tbd)
     *
     * @private
     * @function
     */
	context.define = function defineFunc(name, dep, builder, options) {
        dep = dep || [];
        options = options | {};

		modules[name] = {
			builder: builder,
            built: false,
			exports: null,
            dependencies: dep || [],
			options: options
		};

        if (options.execute) {
            requireFunc(name);
        }
	};

})(window);