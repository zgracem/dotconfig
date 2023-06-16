function __fish_complete_ncurses_caps
    # string replace -rf '^(\w+)\t+(\w+)\t.*' '$2,$1' <ncurses-6.4/include/Caps
    set -l caps \
        bw,auto_left_margin am,auto_right_margin xsb,no_esc_ctlc \
        xhp,ceol_standout_glitch xenl,eat_newline_glitch eo,erase_overstrike \
        gn,generic_type hc,hard_copy km,has_meta_key hs,has_status_line \
        in,insert_null_glitch da,memory_above db,memory_below \
        mir,move_insert_mode msgr,move_standout_mode os,over_strike \
        eslok,status_line_esc_ok xt,dest_tabs_magic_smso hz,tilde_glitch \
        ul,transparent_underline xon,xon_xoff nxon,needs_xon_xoff \
        mc5i,prtr_silent chts,hard_cursor nrrmc,non_rev_rmcup npc,no_pad_char \
        ndscr,non_dest_scroll_region ccc,can_change bce,back_color_erase \
        hls,hue_lightness_saturation xhpa,col_addr_glitch \
        crxm,cr_cancels_micro_mode daisy,has_print_wheel xvpa,row_addr_glitch \
        sam,semi_auto_right_margin cpix,cpi_changes_res lpix,lpi_changes_res \
        cols,columns it,init_tabs lines,lines lm,lines_of_memory \
        xmc,magic_cookie_glitch pb,padding_baud_rate vt,virtual_terminal \
        wsl,width_status_line nlab,num_labels lh,label_height lw,label_width \
        ma,max_attributes wnum,maximum_windows colors,max_colors \
        pairs,max_pairs ncv,no_color_video bufsz,buffer_capacity \
        spinv,dot_vert_spacing spinh,dot_horz_spacing maddr,max_micro_address \
        mjump,max_micro_jump mcs,micro_col_size mls,micro_line_size \
        npins,number_of_pins orc,output_res_char orl,output_res_line \
        orhi,output_res_horz_inch orvi,output_res_vert_inch cps,print_rate \
        widcs,wide_char_size btns,buttons bitwin,bit_image_entwining \
        bitype,bit_image_type cbt,back_tab bel,bell cr,carriage_return \
        csr,change_scroll_region tbc,clear_all_tabs clear,clear_screen \
        el,clr_eol ed,clr_eos hpa,column_address cmdch,command_character \
        cup,cursor_address cud1,cursor_down home,cursor_home \
        civis,cursor_invisible cub1,cursor_left mrcup,cursor_mem_address \
        cnorm,cursor_normal cuf1,cursor_right ll,cursor_to_ll cuu1,cursor_up \
        cvvis,cursor_visible dch1,delete_character dl1,delete_line \
        dsl,dis_status_line hd,down_half_line smacs,enter_alt_charset_mode \
        blink,enter_blink_mode bold,enter_bold_mode smcup,enter_ca_mode \
        smdc,enter_delete_mode dim,enter_dim_mode smir,enter_insert_mode \
        invis,enter_secure_mode prot,enter_protected_mode \
        rev,enter_reverse_mode smso,enter_standout_mode \
        smul,enter_underline_mode ech,erase_chars rmacs,exit_alt_charset_mode \
        sgr0,exit_attribute_mode rmcup,exit_ca_mode rmdc,exit_delete_mode \
        rmir,exit_insert_mode rmso,exit_standout_mode rmul,exit_underline_mode \
        flash,flash_screen ff,form_feed fsl,from_status_line is1,init_1string \
        is2,init_2string is3,init_3string if,init_file ich1,insert_character \
        il1,insert_line ip,insert_padding kbs,key_backspace ktbc,key_catab \
        kclr,key_clear kctab,key_ctab kdch1,key_dc kdl1,key_dl kcud1,key_down \
        krmir,key_eic kel,key_eol ked,key_eos kf0,key_f0 kf1,key_f1 \
        kf10,key_f10 kf2,key_f2 kf3,key_f3 kf4,key_f4 kf5,key_f5 kf6,key_f6 \
        kf7,key_f7 kf8,key_f8 kf9,key_f9 khome,key_home kich1,key_ic \
        kil1,key_il kcub1,key_left kll,key_ll knp,key_npage kpp,key_ppage \
        kcuf1,key_right kind,key_sf kri,key_sr khts,key_stab kcuu1,key_up \
        rmkx,keypad_local smkx,keypad_xmit lf0,lab_f0 lf1,lab_f1 lf10,lab_f10 \
        lf2,lab_f2 lf3,lab_f3 lf4,lab_f4 lf5,lab_f5 lf6,lab_f6 lf7,lab_f7 \
        lf8,lab_f8 lf9,lab_f9 rmm,meta_off smm,meta_on nel,newline \
        pad,pad_char dch,parm_dch dl,parm_delete_line cud,parm_down_cursor \
        ich,parm_ich indn,parm_index il,parm_insert_line cub,parm_left_cursor \
        cuf,parm_right_cursor rin,parm_rindex cuu,parm_up_cursor \
        pfkey,pkey_key pfloc,pkey_local pfx,pkey_xmit mc0,print_screen \
        mc4,prtr_off mc5,prtr_on rep,repeat_char rs1,reset_1string \
        rs2,reset_2string rs3,reset_3string rf,reset_file rc,restore_cursor \
        vpa,row_address sc,save_cursor ind,scroll_forward ri,scroll_reverse \
        sgr,set_attributes hts,set_tab wind,set_window ht,tab \
        tsl,to_status_line uc,underline_char hu,up_half_line iprog,init_prog \
        ka1,key_a1 ka3,key_a3 kb2,key_b2 kc1,key_c1 kc3,key_c3 mc5p,prtr_non \
        rmp,char_padding acsc,acs_chars pln,plab_norm kcbt,key_btab \
        smxon,enter_xon_mode rmxon,exit_xon_mode smam,enter_am_mode \
        rmam,exit_am_mode xonc,xon_character xoffc,xoff_character \
        enacs,ena_acs smln,label_on rmln,label_off kbeg,key_beg \
        kcan,key_cancel kclo,key_close kcmd,key_command kcpy,key_copy \
        kcrt,key_create kend,key_end kent,key_enter kext,key_exit \
        kfnd,key_find khlp,key_help kmrk,key_mark kmsg,key_message \
        kmov,key_move knxt,key_next kopn,key_open kopt,key_options \
        kprv,key_previous kprt,key_print krdo,key_redo kref,key_reference \
        krfr,key_refresh krpl,key_replace krst,key_restart kres,key_resume \
        ksav,key_save kspd,key_suspend kund,key_undo kBEG,key_sbeg \
        kCAN,key_scancel kCMD,key_scommand kCPY,key_scopy kCRT,key_screate \
        kDC,key_sdc kDL,key_sdl kslt,key_select kEND,key_send kEOL,key_seol \
        kEXT,key_sexit kFND,key_sfind kHLP,key_shelp kHOM,key_shome \
        kIC,key_sic kLFT,key_sleft kMSG,key_smessage kMOV,key_smove \
        kNXT,key_snext kOPT,key_soptions kPRV,key_sprevious kPRT,key_sprint \
        kRDO,key_sredo kRPL,key_sreplace kRIT,key_sright kRES,key_srsume \
        kSAV,key_ssave kSPD,key_ssuspend kUND,key_sundo rfi,req_for_input \
        kf11,key_f11 kf12,key_f12 kf13,key_f13 kf14,key_f14 kf15,key_f15 \
        kf16,key_f16 kf17,key_f17 kf18,key_f18 kf19,key_f19 kf20,key_f20 \
        kf21,key_f21 kf22,key_f22 kf23,key_f23 kf24,key_f24 kf25,key_f25 \
        kf26,key_f26 kf27,key_f27 kf28,key_f28 kf29,key_f29 kf30,key_f30 \
        kf31,key_f31 kf32,key_f32 kf33,key_f33 kf34,key_f34 kf35,key_f35 \
        kf36,key_f36 kf37,key_f37 kf38,key_f38 kf39,key_f39 kf40,key_f40 \
        kf41,key_f41 kf42,key_f42 kf43,key_f43 kf44,key_f44 kf45,key_f45 \
        kf46,key_f46 kf47,key_f47 kf48,key_f48 kf49,key_f49 kf50,key_f50 \
        kf51,key_f51 kf52,key_f52 kf53,key_f53 kf54,key_f54 kf55,key_f55 \
        kf56,key_f56 kf57,key_f57 kf58,key_f58 kf59,key_f59 kf60,key_f60 \
        kf61,key_f61 kf62,key_f62 kf63,key_f63 el1,clr_bol mgc,clear_margins \
        smgl,set_left_margin smgr,set_right_margin fln,label_format \
        sclk,set_clock dclk,display_clock rmclk,remove_clock \
        cwin,create_window wingo,goto_window hup,hangup dial,dial_phone \
        qdial,quick_dial tone,tone pulse,pulse hook,flash_hook \
        pause,fixed_pause wait,wait_tone u0,user0 u1,user1 u2,user2 u3,user3 \
        u4,user4 u5,user5 u6,user6 u7,user7 u8,user8 u9,user9 op,orig_pair \
        oc,orig_colors initc,initialize_color initp,initialize_pair \
        scp,set_color_pair setf,set_foreground setb,set_background \
        cpi,change_char_pitch lpi,change_line_pitch chr,change_res_horz \
        cvr,change_res_vert defc,define_char swidm,enter_doublewide_mode \
        sdrfq,enter_draft_quality sitm,enter_italics_mode \
        slm,enter_leftward_mode smicm,enter_micro_mode \
        snlq,enter_near_letter_quality snrmq,enter_normal_quality \
        sshm,enter_shadow_mode ssubm,enter_subscript_mode \
        ssupm,enter_superscript_mode sum,enter_upward_mode \
        rwidm,exit_doublewide_mode ritm,exit_italics_mode \
        rlm,exit_leftward_mode rmicm,exit_micro_mode rshm,exit_shadow_mode \
        rsubm,exit_subscript_mode rsupm,exit_superscript_mode \
        rum,exit_upward_mode mhpa,micro_column_address mcud1,micro_down \
        mcub1,micro_left mcuf1,micro_right mvpa,micro_row_address \
        mcuu1,micro_up porder,order_of_pins mcud,parm_down_micro \
        mcub,parm_left_micro mcuf,parm_right_micro mcuu,parm_up_micro \
        scs,select_char_set smgb,set_bottom_margin \
        smgbp,set_bottom_margin_parm smglp,set_left_margin_parm \
        smgrp,set_right_margin_parm smgt,set_top_margin \
        smgtp,set_top_margin_parm sbim,start_bit_image scsd,start_char_set_def \
        rbim,stop_bit_image rcsd,stop_char_set_def subcs,subscript_characters \
        supcs,superscript_characters docr,these_cause_cr zerom,zero_motion \
        csnm,char_set_names kmous,key_mouse minfo,mouse_info \
        reqmp,req_mouse_pos getm,get_mouse setaf,set_a_foreground \
        setab,set_a_background pfxl,pkey_plab devt,device_type \
        csin,code_set_init s0ds,set0_des_seq s1ds,set1_des_seq \
        s2ds,set2_des_seq s3ds,set3_des_seq smglr,set_lr_margin \
        smgtb,set_tb_margin birep,bit_image_repeat binel,bit_image_newline \
        bicr,bit_image_carriage_return colornm,color_names \
        defbi,define_bit_image_region endbi,end_bit_image_region \
        setcolor,set_color_band slines,set_page_length dispc,display_pc_char \
        smpch,enter_pc_charset_mode rmpch,exit_pc_charset_mode \
        smsc,enter_scancode_mode rmsc,exit_scancode_mode pctrm,pc_term_options \
        scesc,scancode_escape scesa,alt_scancode_esc \
        ehhlm,enter_horizontal_hl_mode elhlm,enter_left_hl_mode \
        elohlm,enter_low_hl_mode erhlm,enter_right_hl_mode \
        ethlm,enter_top_hl_mode evhlm,enter_vertical_hl_mode \
        sgr1,set_a_attributes slength,set_pglen_inch OTi2,termcap_init2 \
        OTrs,termcap_reset OTug,magic_cookie_glitch_ul OTbs,backspaces_with_bs \
        OTns,crt_no_scrolling OTnc,no_correctly_working_cr \
        OTdC,carriage_return_delay OTdN,new_line_delay OTnl,linefeed_if_not_lf \
        OTbc,backspace_if_not_bs OTMT,gnu_has_meta_key \
        OTNL,linefeed_is_newline OTdB,backspace_delay \
        OTdT,horizontal_tab_delay OTkn,number_of_function_keys \
        OTko,other_non_function_keys OTma,arrow_key_map OTpt,has_hardware_tabs \
        OTxr,return_does_clr_eol OTG2,acs_ulcorner OTG3,acs_llcorner \
        OTG1,acs_urcorner OTG4,acs_lrcorner OTGR,acs_ltee OTGL,acs_rtee \
        OTGU,acs_btee OTGD,acs_ttee OTGH,acs_hline OTGV,acs_vline \
        OTGC,acs_plus meml,memory_lock memu,memory_unlock box1,box_chars_1

    string replace ',' \t $caps
end
