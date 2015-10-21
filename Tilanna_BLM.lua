-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    
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
    
    lowTierNukes = S{
        'Stone', 
        'Water', 
        'Aero', 
        'Fire', 
        'Blizzard', 
        'Thunder',
        'Stone II', 
        'Water II', 
        'Aero II', 
        'Fire II', 
        'Blizzard II', 
        'Thunder II',
        'Stone III', 
        'Water III', 
        'Aero III', 
        'Fire III', 
        'Blizzard III', 
        'Thunder III',
        'Stonega', 
        'Waterga', 
        'Aeroga', 
        'Firaga', 
        'Blizzaga', 
        'Thundaga',
        'Stonega II', 
        'Waterga II', 
        'Aeroga II', 
        'Firaga II', 
        'Blizzaga II', 
        'Thundaga II'
    }
    
    gear.default.obi_waist = "Aswang Sash"
    gear.default.obi_back = "Toro Cape"
    
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ------------------------------------------------------------------------
    ----------------------------- Precast Sets -----------------------------
    ------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        --feet="Goetia Sabots +2"
    }
    
    sets.precast.JA.Manafont = {
        --body="Sorcerer's Coat +2"
    }
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}
    
    -- Fast cast sets for spells
    
    sets.precast.FC = {
        main="Keraunos", -- 4%
        ammo="Impatiens",
        head="Nahtirah Hat", -- 10%
        body="Helios Jacket", -- 6%
        ear2="Loquacious Earring", -- 2%
        ring1="Weatherspoon Ring", -- 5%
        ring2="Prolix Ring", -- 2%
        back="Bane Cape", -- 3%
        waist="Witful Belt", -- 3%
        legs="Orvail Pants +1", -- 5%
        feet={
            name="Telchine Pigaches",
            augments={
                '"Fast Cast"+3'
            }
        }, -- 3%
    }
    
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        --waist="Siegel Sash"
    })
    
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
        head="Umuthi Hat",
    })
    
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        head="Wicce Petasos", -- 12%
        neck="Stoicheion Medal",
        ear1="Barkarole Earring",
        ring2="Veneficium Ring",
    })
    
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        back="Pahtli Cape"
    })
    
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
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
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {
        ammo="Witchstone",
        head="Helios Band",
        body="Wicce Coat",
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
        body="Wicce Coat",
        hands="Spaekona's Gloves",
        neck="Weike Torque",
        ear1="Influx Earring",
        ear2="Graiai Earring",
        ring1="Fenrir Ring",
        ring2="Prolix Ring",
        back="Bane Cape",
        waist="Fucho-no-Obi",
        legs="Spaekona's Tonban",
        feet="Telchine Pigaches",
    }
    
    
    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------
    
    -- being lazy for now on FastRecast
    sets.midcast.FastRecast = sets.precast.FC
    
    sets.midcast.Cure = {
        head="Nahtirah Hat",
        neck="Colossus's Torque", -- 7
        body="Vanya Robe",
        hands="Telchine Gloves", -- 10%
        legs="Vanya Slops",
        feet={
            name="Telchine Pigaches",
            augments={
                '"Cure" potency +7%',
                '"Regen" potency +2'
            }
        }, -- 7%
        back="Tempered Cape +1", -- 8, 6%
        waist="Bishop's Sash", -- 5
        ear1="Beatific Earring", -- 4
        ear2="Roundel Earring", -- 5%
        ring1="Haoma's Ring", -- 8
        ring2="Sirona's Ring", -- 10
    }
    
    sets.midcast.Curaga = sets.midcast.Cure
    
    sets.midcast.StatusRemoval = {
        neck="Colossus's Torque", -- 7
        back="Tempered Cape +1", -- 8
        waist="Bishop's Sash", -- 5
        ear1="Beatific Earring", -- 4
        ring1="Haoma's Ring", -- 8
        ring2="Sirona's Ring", -- 10
    }
    
    sets.midcast.Cursna = {
        neck="Malison Medallion",
        back="Oretania's Cape +1",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Haoma's Ring",
    }
    
    sets.midcast.Regen = {
        body="Telchine Chasuble",
        feet={
            name="Telchine Pigaches",
            augments={
                '"Cure" potency +7%',
                '"Regen" potency +2'
            }
        }, -- 2
    }
    
    sets.midcast['Enhancing Magic'] = {
        main="Keraunos",
        sub="Fulcio Grip", -- 3
        head="Umuthi Hat", -- 13
        body="Telchine Chasuble", -- 12
        neck="Colossus's Torque", -- 7
        back="Merciful Cape", -- 5
        waist="Olympus Sash", -- 5
        legs="Portent Pants", -- 15
        ear1="Augmenting Earring", -- 3
        ear2="Andoaa Earring", -- 5
    }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        legs="Haven Hose",
        ear1="Earthcry Earring",
        --waist="Siegel Sash"
    })
    
    sets.midcast.Protect = {
        ring2="Sheltered Ring"
    }
    
    sets.midcast.Shell = {
        ring2="Sheltered Ring"
    }
    
    sets.midcast['Enfeebling Magic'] = {
        main="Lehbrailg +2", -- 25 macc
        sub="Mephitis Grip", -- 5 macc, 5
        range="Aureole", -- 8 macc
        head="Helios Band", -- 27 macc
        neck="Weike Torque", -- 2 macc, 7
        body="Vanya Robe", -- 21 macc, 20
        hands="Hagondes Cuffs +1", -- 20 macc
        legs="Vanya Slops", -- 20 macc
        feet="Helios Boots", -- 26 macc
        back="Bane Cape", -- 10 macc
        waist="Ovate Rope", -- 8 macc
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring", -- 12 macc
        ring1="Weatherspoon Ring", -- 10 macc
        ring2="Perception Ring", -- 6 macc
    }
    
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']
    
    sets.midcast['Dark Magic'] = {
        main="Lehbrailg +2",
        sub="Mephitis Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Vanya Robe",
        hands="Archmage's Gloves +1",
        legs="Spaekona's Tonban",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist="Ovate Rope",
        ear1="Barkarole Earring",
        ear2="Abyssal Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
        back="Bane Cape",
    }
    
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        waist="Fucho-no-Obi",
        ring2="Excelsis Ring",
    })
    
    sets.midcast.Aspir = sets.midcast.Drain
    
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        
    })

    sets.midcast.BardSong = set_combine(sets.midcast['Enfeebling Magic'], {
        neck="Eddy Necklace",
    })
    
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
        main="Keraunos",
        sub="Zuuxowu Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Wicce Coat",
        hands="Helios Gloves",
        legs="Hagondes Pants +1",
        feet="Helios Boots",
        neck="Saevus Pendant +1",
        waist=gear.ElementalObi,
        ear1="Barkarole Earring",
        ear2="Friomisi Earring",
        ring1="Fenrir Ring",
        ring2="Acumen Ring",
        back=gear.default.obi_back
    }
    
    sets.midcast['Elemental Magic'].MidMacc = set_combine(sets.midcast['Elemental Magic'], {
        sub="Wizzan Grip",
        neck="Eddy Necklace",
        ring1="Weatherspoon Ring",
    })
    
    sets.midcast['Elemental Magic'].MaxMacc = set_combine(sets.midcast['Elemental Magic'], {
        sub="Wizzan Grip",
        neck="Eddy Necklace",
        back="Bane Cape",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
    })
    
    sets.midcast['Elemental Magic'].MP = set_combine(sets.midcast['Elemental Magic'], {
        body="Spaekona's Coat +1",
        sub="Wizzan Grip",
        neck="Eddy Necklace",
        ring1="Weatherspoon Ring",
    })
    
    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Enfeebling Magic'], {
        main="Earth Staff",
    })
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        main="Chatoyant Staff",
    }
    
    ------------------------------------------------------------------------
    ------------------------------ Idle Sets -------------------------------
    ------------------------------------------------------------------------
    
    -- Normal refresh idle set
    sets.idle = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        ammo="Ghastly Tathlum +1",
        head="Nahtirah Hat",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Merman's Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
    
    sets.idle.PDT = {
        main="Earth Staff",
        sub="Wizzan Grip",
        ammo="Ghastly Tathlum +1",
        head="Nahtirah Hat",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Roundel Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
    
    sets.idle.MDT = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        ammo="Ghastly Tathlum +1",
        head="Nahtirah Hat",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Wiglen Gorget",
        waist="Flax Sash",
        ear1="Merman's Earring",
        ear2="Merman's Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
    
    -- Defense sets
    
    sets.defense.PDT = {
        main="Earth Staff",
        sub="Wizzan Grip",
        ammo="Ghastly Tathlum +1",
        head="Nahtirah Hat",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Roundel Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
    
    sets.defense.MDT = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        ammo="Ghastly Tathlum +1",
        head="Nahtirah Hat",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Herald's Gaiters",
        neck="Wiglen Gorget",
        waist="Flax Sash",
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
    
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {
        --feet="Goetia Sabots +2"
    }
    
    sets.magic_burst = {
        neck="Mizukage-no-Kubikazari", -- 10%
        hands="Archmage's Gloves +1", -- 16%
        back="Seshaw Cape", -- 5%
        ring1="Locus Ring", -- 5%
        ring2="Mujin Band", -- 5%
    }
    
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {
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
    
    sets.engaged.Refresh = sets.idle
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        --gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        --gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
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
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
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
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 1)
end

