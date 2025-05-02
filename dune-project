(lang dune 3.18)

(name quest_complete)

(generate_opam_files true)

(source
 (github aguluman/quest_complete))

(authors "aguluman <chukwumaakunyili@gmail.com>")

(maintainers "aguluman <chukwumaakunyili@gmail.com>")

(license MIT)

(package
 (name quest_complete)
 (synopsis "Track and celebrate the games you’ve conquered")
 (description
  "QuestComplete is your ultimate companion for tracking completed video games. Keep a record of your gaming victories, relive your favorite quests, and celebrate your progress in style. Level up your gaming organization with QuestComplete!")
 (depends
  ocaml
  containers
  dream
  caqti-driver-postgresql
  pure-html
  reality_assets
  reality_tailwindcss
  simple_dotenv)
 (tags
  ("website" "games" "completion")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
