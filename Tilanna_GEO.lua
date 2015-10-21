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
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Refresh')
    state.CastingMode:options('Normal', 'Resistant', 'MP')
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')

    gear.default.weaponskill_waist = "Windbuffet Belt"
    gear.default.obi_waist = "Aswang Sash"
    gear.default.obi_back = "Toro Cape"
    gear.default.obi_ring = "Fenrir Ring"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {
        body="Bagua Tunic"
    }
    sets.precast.JA['Life Cycle'] = {
        body="Geomancy Tunic"
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        main="Marin Staff", -- 2%
        ammo="Impatiens",
        head="Nahtirah Hat", -- 10%
        body="Helios Jacket", -- 6%
        --hands="",
        ear2="Loquacious Earring", -- 2%
        ring1="Weatherspoon Ring", -- 5%
        ring2="Prolix Ring", -- 2%
        back="Lifestream Cape", -- 7%
        waist="Witful Belt", -- 3%
        legs="Geomancy Pants", -- 10%
        feet={
            name="Telchine Pigaches",
            augments={
                '"Fast Cast"+3'
            }
        }, -- 3%
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        main="Tamaxchi",
        sub="Sors Shield",
        --back="Pahtli Cape"
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        neck="Stoicheion Medal",
        --hands="Bagua Mitaines",
        ear1="Barkarole Earring",
    })

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        head=empty,
        body="Twilight Cloak"
    })
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Ghastly Tathlum +1",
        head="Telchine Cap",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Telchine Pigaches",
        neck="Fotia Gorget",
        waist="Windbuffet Belt",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Umbra Cape"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        ammo="Witchstone",
        head="Helios Band",
        body="Hagondes Coat +1",
        hands="Otomi Gloves",
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

    sets.precast.WS['Starlight'] = {
        --ear2="Moonshade Earring"
    }

    sets.precast.WS['Moonlight'] = sets.precast.WS['Starlight']


    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------
    
    -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Geomancy = {
        range="Dunna",
		body="Bagua Tunic",
		hands="Geomancy Mitaines",
		back="Lifestream Cape",
    }
    
    sets.midcast.Geomancy.Indi = {
        range="Dunna",
		body="Bagua Tunic",
		hands="Geomancy Mitaines",
        --legs="Bagua Pants"
		back="Lifestream Cape",
    }

    sets.midcast.Cure = {
        main="Tamaxchi", -- 22%
        sub="Sors Shield", -- 3%
        head="Telchine Cap",
        neck="Colossus's Torque", -- 7
        body="Telchine Chasuble",
        hands="Telchine Gloves", -- 10%
        feet={
            name="Telchine Pigaches",
            augments={
                '"Cure" potency +7%',
                '"Regen" potency +2'
            }
        }, -- 7%
        back="Oretania's Cape +1", -- 6%
        waist="Bishop's Sash", -- 5
        ear1="Beatific Earring", -- 4
        ear2="Roundel Earring", -- 5%
        ring1="Haoma's Ring", -- 8
        ring2="Sirona's Ring", -- 10
    }
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Cursna = {
        neck="Malison Medallion",
        back="Oretania's Cape +1",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Sirona's Ring",
    }
    
    sets.midcast.StatusRemoval = {
        neck="Colossus's Torque",
        back="Altruistic Cape",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Sirona's Ring",
    }
    
    sets.midcast['Enhancing Magic'] = {
        main="Marin Staff",
        sub="Fulcio Grip",
        head="Telchine Cap",
        neck="Colossus's Torque",
        body="Telchine Chasuble",
        back="Merciful Cape",
        waist="Olympus Sash",
        ear1="Augmenting Earring",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        ear1="Earthcry Earring",
        legs="Haven Hose"
    })
    
    sets.midcast.Regen = {
        body="Telchine Chasuble",
        feet="Telchine Pigaches" -- 2
    }

    sets.midcast.Protect = {
        ring2="Sheltered Ring",
    }
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {
        ring2="Sheltered Ring",
    }
    sets.midcast.Shellra = sets.midcast.Shell
    
    sets.midcast['Enfeebling Magic'] = {
        main="Lehbrailg +2",
        sub="Mephitis Grip",
        range="Aureole",
        head="Telchine Cap",
        neck="Weike Torque",
        
        hands="Hagondes Cuffs +1",
        waist="Ovate Rope",
        
        feet="Bagua Sandals",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
        back="Lifestream Cape",
    }
    
    sets.midcast['Elemental Magic'] = {
        main="Marin Staff",
        sub="Zuuxowu Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Hagondes Coat +1",
        hands="Helios Gloves",
        legs="Hagondes Pants +1",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist=gear.ElementalObi,
        ear1="Barkarole Earring",
        ear2="Friomisi Earring",
        ring1=gear.ElementalRing,
        ring2="Acumen Ring",
        back=gear.default.obi_back,
    }
    
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        main="Lehbrailg +2",
        sub="Wizzan Grip",
        hands="Hagondes Cuffs +1",
        ring1="Weatherspoon Ring"
    })
    
    sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {
        waist=gear.default.obi_waist
    })
    
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak"
    })
    
    sets.midcast['Dark Magic'] = {
        main="Lehbrailg +2",
        sub="Wizzan Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Arbatel Gown",
        hands="Otomi Gloves",
        legs="Pedagogy Pants",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist="Ovate Rope",
        ear1="Barkarole Earring",
        ear2="Friomisi Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
        back="Bookworm's Cape"
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        waist=gear.ElementalObi,
        ring1=gear.ElementalRing,
        ring2="Excelsis Ring",
        back=gear.ElementalCape,
    })

    sets.midcast.Aspir = sets.midcast.Drain
    
    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        range="Dunna",
        head="Telchine Cap",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Geomancy Sandals",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }
    
    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff"
    })
    
    sets.idle.PDT = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        range="Dunna",
        head="Telchine Cap",
        neck="Wiglen Gorget",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape",
        waist="Aswang Sash",
        legs="Assiduity Pants +1",
        feet="Geomancy Sandals",
    }
    
    -- .Pet sets are for when Luopan is present.
    --[[sets.idle.Pet = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}

    sets.idle.PDT.Pet = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {legs="Bagua Pants"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {legs="Bagua Pants"})

    -- Defense sets

    sets.defense.PDT = {range="Dunna",
        head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.defense.MDT = {range="Dunna",
        head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}]]

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        ammo="Ghastly Tathlum +1",
        head="Telchine Cap",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Assiduity Pants +1",
        feet="Telchine Pigaches",
        neck="Asperity Necklace",
        waist="Windbuffet Belt",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Umbra Cape"
	}
    
    sets.engaged.Refresh = sets.idle

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    
    sets.magic_burst = {
        neck="Mizukage-no-Kubikazari",
        back="Seshaw Cape",
        ring1="Locus Ring",
        ring2="Mujin Band"
    }
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            --send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            --send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

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

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

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
    set_macro_page(1, 6)
end

