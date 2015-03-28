# Learn Your Damn Homophones

This site is built with [Middleman](http://middlemanapp.com), a static site generator. The source is available in the `source/` directory. Middleman builds the site from the parsed ERb and SCSS into a `build/` folder. The site is deployed to S3 and Cloudfront.

To run locally:

    middleman server

To build:

    middleman build

To deploy to S3:

    middleman s3_sync

To invalidate the Cloudfront cache:

    AWS_ACCESS_KEY_ID= AWS_SECRET_ACCESS_KEY= middleman invalidate

## Contributing

If you've found LYDH to be useful and want to contribute, you can do so in two main ways: 1) by adding new homophones to the list and 2) by making the site itself better.

### Adding a new homophone
The table is rendered by Middleman from a JSON file stored in `data/table.json`. It is an array containing objects with two members: `words`, which is an array itself, and `hint`, which has a single `text` attribute, used to render the hints in the table. The `words` array contains objects with members `word`, defining a homophone, and `explanation`, giving an example sentence using the homophone.

To add a new homophone, create a new object in the array. As you can tell, the list is sorted alphabetically; please add the new object in the appropriate location. Your object should look something like this:

```json
{
  "words": [
    {
      "word": "Word1",
      "explanation": "A sentence with <em>word1</em>."
    },
    {
      "word": "Word2",
      "explanation": "A sentence with <em>word2</em>.>."
    }
  ],
  "hint": {
    "text": "<em>Word1</em> is most commonly a noun; <em>word2</em> is most commonly a verb."
  }
}
```

Notice that we use `em` to highlight the word in the sentence so it stands out. Also, the `hint` object is **optional**; only use it when there's a hard-and-fast rule you can apply to aid comprehension.

### Making the site better

There are a lot of ways to make the site itself better, and I'm always open to suggestions on features and design enhancements that will aid users of the site. You can check the issues tracker for things I've noted as possible enhancements, but feel free to propose your own changes as well.

### Opening a pull request

To make your changes, fork the repo, commit on a branch and then open a pull request. Please use Middleman's development server to check your changes and manually inspect the `build` folder to ensure you haven't accidentally introduced any regressions or performance concerns.