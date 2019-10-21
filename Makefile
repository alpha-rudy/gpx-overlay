ROOT_DIR := $(shell pwd)
TOOLS_DIR := $(ROOT_DIR)/tools
VERSION := $(shell date +%Y.%m.%d)

JAVACMD_OPTIONS := -Xmx25G -server
MAPWITER_THREADS = 8
TAIWAN_BBOX=21.55682,118.12141,26.44212,122.31377

MAPS := $(GPX_BASE).map

.PHONY: all clean
all: $(MAPS:%.map=%.map.zip)

clean:
	git clean -fdx

.INTERMEDIATE: $(MAPS:%.map=%.pbf)
%.pbf: %.osm
	osmconvert $< -o=$@

.INTERMEDIATE: $(MAPS:%.map=%-sed.pbf)
%-sed.pbf: %.pbf
	rm -f $@
	python3 osm_scripts/gpx_handler.py $< $@

%.map: %-sed.pbf osm_scripts/gpx-mapping.xml
	export JAVACMD_OPTIONS="$(JAVACMD_OPTIONS)" && \
	sh $(TOOLS_DIR)/osmosis/bin/osmosis \
	  --read-pbf $< \
	  --buffer --mapfile-writer \
	    type=ram \
	    threads=$(MAPWITER_THREADS) \
	    bbox=$(TAIWAN_BBOX) \
	    preferred-languages="zh,en" \
		label-position=false \
	    tag-conf-file=osm_scripts/gpx-mapping.xml \
	    polygon-clipping=true way-clipping=true label-position=true \
	    zoom-interval-conf=6,0,6,10,7,11,14,12,21 \
	    map-start-zoom=12 \
	    comment="$(VERSION) / (c) GPX Overlay Copy Right: $(notdir $(GPX_BASE))" \
	    file="$@" > /dev/null 2> /dev/null

%.map.zip: %.map
	7z a -tzip $@ $^
