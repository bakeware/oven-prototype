# nerves.mk 	bakeware.io makefile for Frank Hunleth's "Nerves" SDK
#
# sdk_type	should always be "nerves" for now
# sdk_config	type of configuration for nerves
#
# (C) 2015 bakeware.io - not an open source project at this time

sdk = ~/sdks/$(sdk_type)/$(sdk_config)
sdk_repo = git@github.com:nerves-project/nerves-sdk.git

$(sdk)/.stamp_cloned:
	echo "bake: setting up sdk "$(sdk)
	mkdir -p $(sdk)
	git clone $(sdk_repo) $(sdk)
	touch $(sdk)/.stamp_cloned
	
$(sdk)/.stamp_configured: $(sdk)/.stamp_cloned
	make -C $(sdk) $(sdk_config)_defconfig
	touch $(sdk)/.stamp_configured
#	rm -rf $(sdk)/config
#	mkdir -p $(sdk)/config
#	cp -r config/nerves/* _nerves/config
#	cp config/nerves.config _nerves/configs/current_defconfig
#cd -C $(sdk)

$(sdk)/.stamp_built: $(sdk)/.stamp_configured
	make -C $(sdk)
	touch $(sdk)/.stamp_built

sdk: $(sdk)/.stamp_built
	
set-build-env: $(sdk)/.stamp_built
	@echo $(sdk)/nerves-env.sh	
