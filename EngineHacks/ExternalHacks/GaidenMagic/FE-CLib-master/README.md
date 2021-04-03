
This is a set a C headers along with reference object sources for the purpose of writing FE8 wizardry. Only a FE8U reference is available for now, but adding a FE8J reference is feasible.

Much like [the python tools](https://github.com/StanHash/FE-PyTools), this was previously located within [FE-CHAX](https://github.com/StanHash/FE-CHAX). This is now being moved in its own repository since I will start using it in other projects too (namely in my [port of VBA to make/EA](https://github.com/StanHash/VBA-MAKE)).

## Usage

- Add the `include` directory to your include path, and include `gbafe.h` in the sources in which you may want to use FE8 stuff.
- Build the *latest* corresponding reference object (sources in the `reference` directory) and link against it.

_**Note**: as of 2019-01-02, I removed all `#pragma long_calls` from the headers. This means that you will have to rely on either compiler or linker flags if you need long calls to work._

## Reference objects

I call "reference object" a relocatable object that only defines a series of global absolute symbols mapping names to addresses in a given game. For example, a reference object for FE8U will define a symbol named `gActiveUnit` with absolute value `03004E50`.

This "reference object" may be used to "link" the game to your code.

The symbol names in the latest reference object should correspond to the symbol names in the current gbafe headers. *However*, names in previous reference objects may not correspond to current libgbafe. Those are provided to better prepare users for breaks in compatibility.

### Updating the reference

Basically since I'm bad I change function and object names a lot. But I try to be nice anyway so I'm trying to provide an easy-ish way to "update" from an older nameset to the latest one.

You may note that reference object sources have dates attached to their names. That's because the plan is to keep all the previous references in so that is becomes easier to "port" your code to a newer version of FE-CLib.

I have written [an updating helper script](./utility/update-reference-object.sh) that may help you update from an old reference to the latest one. It requires `lyn` to compare references, but it isn't necessarily meant to be excusively used for updating a `lyn`-based environment.

The way it works is fairly simple: it uses `lyn` to generate a "diff" of the symbol map defined by two objects, generates a series of `sed` invocations that should replace old names with new names; and then it calls those for each .h, .c and .s files it can find under the working directory.

Basically how you'd use it is like this:

```sh
cd path/to/directory/to/update
sh path/to/utility/update-reference-object.sh path/to/old/reference.o path/to/new/reference.o
```

You could also use this to port your already written code from your old stuff to this! Or vice-versa, if you want code written for this to work in your environment with a custom reference.
