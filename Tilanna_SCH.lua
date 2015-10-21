-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Refresh')
    state.CastingMode:options('Normal', 'MidMacc', 'MaxMacc', 'MP', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	
    state.MagicBurst = M(false, 'Magic Burst')
	
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
	
    gear.default.obi_waist = "Aswang Sash"
    gear.default.obi_back = "Bookworm's Cape"
	
    select_default_macro_book()
end

function user_unload()
    
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
    -- Precast Sets
	
    -- Precast sets to enhance JAs
	
    sets.precast.JA['Tabula Rasa'] = {
        legs="Pedagogy Pants"
    }
    
    sets.precast.JA['Enlightenment'] = {
        body="Pedagogy Gown +1"
    }
	
    -- Fast cast sets for spells
	
    sets.precast.FC = {
        main="Keraunos", -- 4%
        ammo="Impatiens",
        head="Nahtirah Hat", -- 10%
        body="Helios Jacket", -- 6%
        hands="Gendewitha Gages", -- 7%
        ear2="Loquacious Earring", -- 2%
        ring1="Weatherspoon Ring", -- 5%
        ring2="Prolix Ring", -- 2%
        back="Swith Cape", -- 3%
        waist="Witful Belt", -- 3%
        legs="Orvail Pants +1", -- 5%
        feet="Pedagogy Loafers +1", -- 6%
    }
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        --waist="Siegel Sash"
    })
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
    })
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        neck="Stoicheion Medal",
        ear1="Barkarole Earring",
    })
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        --body="Heka's Kalasiris",
        back="Pahtli Cape"
    })
	
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak"
    })
	
    sets.precast.WS = {
        ammo="Witchstone",
        head="Telchine Cap",
        body="Vanya Robe",
        hands="Archmage's Gloves +1",
        legs="Assiduity Pants +1",
        feet="Battlecast Gaiters",
        neck="Fotia Gorget",
        waist="Windbuffet Belt",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Umbra Cape"
    }
	
	sets.precast.WS['Omniscience'] = {
        ammo="Witchstone",
        head="Helios Band",
        body="Arbatel Gown",
        hands="Helios Gloves",
        legs="Hagondes Pants +1",
        feet="Helios Boots",
        neck="Saevus Pendant +1",
        waist="Aswang Sash",
        ear1="Barkarole Earring",
        ear2="Friomisi Earring",
        ring1="Acumen Ring",
        ring2="Fenrir Ring",
        back="Toro Cape",
    }
    
    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Nahtirah Hat",
        body="Academic's Gown +1",
        hands="Telchine Gloves",
        neck="Weike Torque",
        ear1="Influx Earring",
        ear2="Graiai Earring",
        ring1="Fenrir Ring",
        ring2="Prolix Ring",
        back="Phatli Cape",
        waist="Fucho-no-Obi",
        legs="Pedagogy Pants",
        feet="Arbatel Loafers +1",
    }
	
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Midcast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.midcast.FastRecast = sets.precast.FC
	
    sets.midcast.Cure = {
        head="Gendewitha Caubeen +1", -- 10%
        neck="Colossus's Torque", -- 7
        body="Pedagogy Gown +1", -- 15
        hands="Telchine Gloves", -- 10%
        legs="Academic's Pants +1", -- 15
        feet={
            name="Telchine Pigaches",
            augments={
                '"Cure" potency +7%',
                '"Regen" potency +2'
            }
        }, -- 7%
        back="Tempered Cape +1", -- 6%
        waist="Bishop's Sash", -- 5
        ear1="Beatific Earring", -- 4
		ear2="Lifestorm Earring",
        ring1="Haoma's Ring", -- 8
        ring2="Sirona's Ring", -- 10
    }
	
    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff",
    })
	
    sets.midcast.Curaga = sets.midcast.Cure
	
    sets.midcast.Regen = {
        head="Arbatel Bonnet",
        body="Telchine Chasuble",
        feet={
            name="Telchine Pigaches",
            augments={
                '"Cure" potency +7%',
                '"Regen" potency +2'
            }
        },
    }
    
    sets.midcast.StatusRemoval = {
        neck="Colossus's Torque",
        legs="Academic's Pants +1",
        feet="Pedagogy Loafers +1",
        back="Tempered Cape +1",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Sirona's Ring",
    }
	
    sets.midcast.Cursna = {
        neck="Malison Medallion",
        legs="Academic's Pants +1",
        feet="Gendewitha Galoshes",
        back="Oretania's Cape +1",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Haoma's Ring",
    }
	
    sets.midcast['Enhancing Magic'] = {
		main="Keraunos",
        sub="Fulcio Grip",
        --ammo="Savant's Treatise",
        neck="Colossus's Torque",
        head="Umuthi Hat",
        body="Pedagogy Gown +1",
        legs="Academic's Pants +1",
        back="Merciful Cape",
        waist="Olympus Sash",
        ear1="Augmenting Earring",
		ear2="Andoaa Earring",
    }
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        ear1="Earthcry Earring",
        legs="Haven Hose"
    })
	
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Pedagogy Loafers +1",
    })
	
    sets.midcast.Protect = {
        ring2="Sheltered Ring",
    }
    sets.midcast.Protectra = sets.midcast.Protect
	
    sets.midcast.Shell = {
        ring2="Sheltered Ring",
    }
    sets.midcast.Shellra = sets.midcast.Shell
	
    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Lehbrailg +2",
        sub="Mephitis Grip",
        range="Aureole",
        head="Helios Band",
        neck="Weike Torque",
        body="Vanya Robe",
        hands="Hagondes Cuffs +1",
        legs="Arbatel Pants",
        feet="Helios Boots",
        back="Refraction Cape",
        waist="Ovate Rope",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        
    })
    
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
	
    sets.midcast['Dark Magic'] = {
        main="Lehbrailg +2",
        sub="Mephitis Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Academic's Gown +1",
        hands="Hagondes Cuffs +1",
        legs="Pedagogy Pants",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist="Ovate Rope",
        ear1="Barkarole Earring",
        ear2="Abyssal Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
        back="Bookworm's Cape"
    }
	
    sets.midcast.Kaustra = {
        main="Keraunos",
        sub="Wizzan Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Arbatel Gown",
        hands="Helios Gloves",
        legs="Hagondes Pants",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist=gear.ElementalObi,
        ear1="Barkarole Earring",
        ear2="Friomisi Earring",
        ring1="Fenrir Ring",
        ring2="Acumen Ring",
        back=gear.ElementalCape,
    }
    
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        waist="Fucho-no-Obi",
        ring2="Excelsis Ring",
    })
	
    sets.midcast.Aspir = sets.midcast.Drain
	
    sets.midcast.Stun = {
        main="Lehbrailg +2",
        sub="Mephitis Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Academic's Gown +1",
        hands="Hagondes Cuffs +1",
        legs="Pedagogy Pants",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist="Ovate Rope",
        ear1="Barkarole Earring",
        ear2="Abyssal Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
        back="Bookworm's Cape"
    }
	
    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
        main="Keraunos",
        sub="Zuuxowu Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Arbatel Gown",
        hands="Helios Gloves",
        legs="Hagondes Pants +1",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist=gear.ElementalObi,
        ear1="Barkarole Earring",
        ear2="Friomisi Earring",
        ring1="Fenrir Ring",
        ring2="Acumen Ring",
        back=gear.default.obi_back
    }
	
	sets.midcast['Elemental Magic'].MidMacc = set_combine(sets.midcast['Elemental Magic'], {
        sub="Wizzan Grip",
		ring1="Weatherspoon Ring",
    })
	
	sets.midcast['Elemental Magic'].MaxMacc = set_combine(sets.midcast['Elemental Magic'], {
        sub="Wizzan Grip",
		hands="Hagondes Cuffs +1",
		ring1="Weatherspoon Ring",
		ring2="Perception Ring",
    })
	
    sets.midcast['Elemental Magic'].MP = set_combine(sets.midcast['Elemental Magic'], {
        sub="Wizzan Grip",
        --body="Seidr Cotehardie",
		ring1="Weatherspoon Ring",
    })
	
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak"
    })
    
    sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {
        waist=gear.default.obi_waist
    })
    
    sets.midcast.Helix.MidMacc = set_combine(sets.midcast['Elemental Magic'].MidMacc, {
        waist=gear.default.obi_waist
    })
    
    sets.midcast.Helix.MaxMacc = set_combine(sets.midcast['Elemental Magic'].MaxMacc, {
        waist=gear.default.obi_waist
    })
	
    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.idle = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        ammo="Homiliary",
        head="Gendewitha Caubeen +1",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Wiglen Gorget",
        waist="Fucho-no-Obi",
        ear1="Colossus's Earring",
        ear2="Merman's Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
    
    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff"
    })
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.defense.PDT = {
        main="Earth Staff",
        sub="Wizzan Grip",
        ammo="Ghastly Tathlum +1",
        head="Gendewitha Caubeen +1",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Hagondes Pants +1",
        feet="Battlecast Gaiters",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
	
    sets.defense.MDT = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        ammo="Ghastly Tathlum +1",
        head="Gendewitha Caubeen +1",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Twilight Torque",
        waist="Aswang Sash",
        ear1="Merman's Earring",
        ear2="Merman's Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
	
    sets.Kiting = {
        feet="Herald's Gaiters"
    }
	
    sets.latent_refresh = {
        waist="Fucho-no-obi"
    }
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.engaged = {
        head="Telchine Cap",
        body="Vanya Robe",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Battlecast Gaiters",
        neck="Fotia Gorget",
        waist="Windbuffet Belt",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Umbra Cape"
	}
    
    sets.engaged.Refresh = sets.idle
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.magic_burst = {
        neck="Mizukage-no-Kubikazari",
        back="Seshaw Cape",
        ring1="Locus Ring",
        ring2="Mujin Band",
    }
	
    sets.buff['Ebullience'] = {
        head="Arbatel Bonnet"
    }
	
    sets.buff['Rapture'] = {
        head="Arbatel Bonnet"
    }
    
    sets.buff['Perpetuance'] = {
        hands="Arbatel Bracers"
    }
    
    sets.buff['Immanence'] = {
        hands="Arbatel Bracers"
    }
    
    sets.buff['Penury'] = {
        legs="Arbatel Pants"
    }
    
    sets.buff['Parsimony'] = {
        legs="Arbatel Pants"
    }
    
    sets.buff['Celerity'] = {
        feet="Pedagogy Loafers +1"
    }
    
    sets.buff['Alacrity'] = {
        feet="Pedagogy Loafers +1"
    }
	
    sets.buff['Klimaform'] = {
        feet="Arbatel Loafers +1"
    }
	
    sets.buff.FullSublimation = {
        head="Academic's Mortarboard +1",
        --ear1="Savant's Earring",
        body="Pedagogy Gown +1",
    }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
	elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end

