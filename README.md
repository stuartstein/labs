# The SortedArray Lab

In this lab you will build a SortedArray class.  Each instance of SortedArray will hold an array, and when you add elements to a SortedArray, they will automatically be placed into the internal array in sorted order.

We are providing a template (`sorted_array_template.rb`) which has stubs of methods you need (make more if it makes sense or if you want to), and a spec (`sorted_array_spec.rb`) which will help you get everything working.  You can add tests to the spec, but don't delete any.

When you first run the spec, there will be a lot of errors and a lot of red.  Don't be alarmed.  Implement the methods one at a time.  Commit often and plan each method before starting it.

### Recommended Order for Implementing Methods
1. `SortedArray#[]` will be short.  Come back to it if you don't get it.
2. `SortedArray#first_larger_index`
3. `SortedArray#add`
4. `SortedArray#initialize`
5. `SortedArray#index`

`initialize` will use `add`, which will use `first_larger_index`.

Submit your lab through the lab submission form.