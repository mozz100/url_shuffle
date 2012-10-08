Two Ruby scripts to help webmasters.

What problem does this solve?
-----------------------------

Our website was getting disorganised with many URLs like these:

        /lonestar_distributors
        /detect-chemical-123-with-lonestar
        /lonestar_markets
        /lonestar_industrial
        ...

I used these two scripts to enable me to rejig the URLs, whilst keeping track of the moves.

Keeping track is important, because it's necessary to:

- share what you're planning to do with others in a concise fashion, and give them chance to approve/proofread
- automate the changes to URLs (we use Drupal so this will be easy)
- place 301 redirects at the old URLs (maintain Google juice and user experience)

How does it solve it?
---------------------

1.  Starts from a list of URLs in a file called `existing_urls.txt`

        /lonestar_distributors
        /detect-chemical-123-with-lonestar
        /lonestar_markets
        /lonestar_industrial
        ...

2.  Run `generate_folder.rb` to build a folder of files that mirrors the existing website structure.  See `examples/urls_20121008_142600`

3.  At this point it's convenient to make a copy of the folder.  You shouldn't need it, but you never know.

4.  You use Explorer/Finder/whatever you like to move the files around, create subfolders, rename the files.  See `examples/urls_20121008_142600_final`

5.  Run `generate_redirects.rb` and enter the name of the folder from step 4.  It outputs `redirects.csv`.  See `examples/redirects.csv`

    (spaces added for readability below)

        FROM,                               TO
        /lonestar_distributors,             /lonestar/distributors
        /detect-chemical-123-with-lonestar, /lonestar/apps/detect-chemical-123
        /lonestar_markets,                  /lonestar/markets
        /lonestar_industrial                /lonestar/markets/industrial
        ...
