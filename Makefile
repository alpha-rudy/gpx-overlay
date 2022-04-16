ROOT_DIR := $(shell pwd)
TOOLS_DIR := $(ROOT_DIR)/tools
VERSION := $(shell date +%Y.%m.%d)

JAVACMD_OPTIONS := -Xmx25G -server
MAPWITER_THREADS = 8
TAIWAN_BBOX=21.55682,118.12141,26.44212,122.31377
OSMOSIS=osmosis-0.48.3/bin/osmosis

MAPS := $(shell ls *.osm)

.PHONY: all clean
all: $(MAPS:%.osm=%.map.zip)

clean:
	git clean -fX

.INTERMEDIATE: $(MAPS:%.osm=%.pbf)
%.pbf: %.osm
	osmconvert $< -o=$@

.INTERMEDIATE: $(MAPS:%.osm=%-sed.pbf)
%-gpx-sed.pbf: %-gpx.pbf
	rm -f $@
	python3 osm_scripts/gpx_handler.py $< $@

.PRECIOUS: $(MAPS:%.osm=%.map)
%-gpx.map: %-gpx-sed.pbf osm_scripts/gpx-mapping.xml
	export JAVACMD_OPTIONS="$(JAVACMD_OPTIONS)" && \
	sh $(TOOLS_DIR)/$(OSMOSIS) \
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
	    comment="GPX Overlay $@ v$(VERSION) / (c) Copy Right Reserved." \
	    file="$@" > /dev/null 2> /dev/null

%.map: %.pbf osm_scripts/extra-mapping.xml
	export JAVACMD_OPTIONS="$(JAVACMD_OPTIONS)" && \
	sh $(TOOLS_DIR)/$(OSMOSIS) \
	  --read-pbf $< \
	  --buffer --mapfile-writer \
	    type=ram \
	    threads=$(MAPWITER_THREADS) \
	    bbox=$(TAIWAN_BBOX) \
	    preferred-languages="zh,en" \
      label-position=false \
	    tag-conf-file=osm_scripts/extra-mapping.xml \
	    polygon-clipping=true way-clipping=true label-position=true \
	    zoom-interval-conf=6,0,6,10,7,11,14,12,21 \
	    map-start-zoom=12 \
	    comment="Extra Overlay $@ v$(VERSION) / (c) Copy Right Reserved." \
	    file="$@" > /dev/null 2> /dev/null

%.map.zip: %.map
	7z a -tzip $@ $^
