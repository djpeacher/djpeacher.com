start:
    hugo server -D

write name="new":
    hugo new posts/{{ name }}.md

format post="":
    ls -v content/posts/{{ post }}/*.JPG | cat -n | while read n f; do mv -n "$f" "content/posts/{{ post }}/{{ post }}$(printf "%03d\n" $n).jpg"; done
    sips -s artist "Jonathan Peacher" -s copyright "© Jonathan Peacher" -Z 2000 content/posts/{{ post }}/*.jpg