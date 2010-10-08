%%-*- mode: erlang -*-
{application, egs, [
	{description, "EGS online action-RPG game server"},
	{vsn, "0.1"},
	{modules, [
		egs,
		egs_app,
		egs_sup,
		egs_conf,
		egs_seasons,
		egs_items_db,
		egs_shops_db,
		egs_game_server,
		egs_login_server,
		egs_exit_mon,
		egs_user_model,
		egs_network,
		egs_login,
		egs_char_select,
		egs_game,
		reloader,
		psu_game,
		psu_patch,
		psu_instance,
		psu_proto,
		psu_appearance,
		psu_characters,
		psu_party,
		psu_npc,
		psu_parser
	]},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
		crypto,
		ssl,
		mnesia
	]},
	{mod, {egs_app, []}},
	{env, []}
]}.
