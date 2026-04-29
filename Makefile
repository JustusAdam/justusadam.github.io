.PHONY: serve build thumbs

thumbs:
	python3 scripts/gen_poster_thumbs.py

serve: thumbs
	zola serve

build: thumbs
	zola build
