// Lean compiler output
// Module: LoVe.LoVe01_TypesAndTerms_HomeworkSheet
// Imports: Init LoVe.LoVelib
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
LEAN_EXPORT lean_object* l_LoVe_B(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense1___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__2(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense1___lam__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense2(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense4___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_S(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense2___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense4___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense3(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_weakPeirce(lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense2___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_nonsense4(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_B(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_apply_1(x_2, x_3);
x_5 = lean_apply_1(x_1, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_S(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
lean_inc(x_3);
x_4 = lean_apply_1(x_2, x_3);
x_5 = lean_apply_2(x_1, x_3, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense1___lam__0(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_inc(x_1);
return x_1;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense1(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_alloc_closure((void*)(l_LoVe_nonsense1___lam__0___boxed), 2, 1);
lean_closure_set(x_4, 0, x_3);
x_5 = lean_apply_2(x_1, x_2, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense1___lam__0___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_LoVe_nonsense1___lam__0(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
return x_3;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense2___redArg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_apply_1(x_1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense2(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lean_apply_1(x_2, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense2___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_LoVe_nonsense2(x_1, x_2, x_3, x_4);
lean_dec(x_3);
lean_dec(x_1);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense3(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_alloc_closure((void*)(l_LoVe_nonsense1___lam__0___boxed), 2, 1);
lean_closure_set(x_4, 0, x_3);
x_5 = lean_apply_2(x_1, x_4, x_2);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense4___redArg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_apply_1(x_1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense4(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lean_apply_1(x_2, x_3);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_nonsense4___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_LoVe_nonsense4(x_1, x_2, x_3, x_4);
lean_dec(x_4);
lean_dec(x_1);
return x_5;
}
}
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__0(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_inc(x_1);
return x_1;
}
}
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__1(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; lean_object* x_4; 
x_3 = lean_alloc_closure((void*)(l_LoVe_weakPeirce___lam__0___boxed), 2, 1);
lean_closure_set(x_3, 0, x_2);
x_4 = lean_apply_1(x_1, x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__2(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_apply_1(x_2, x_1);
return x_3;
}
}
LEAN_EXPORT lean_object* l_LoVe_weakPeirce(lean_object* x_1) {
_start:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; 
lean_inc(x_1);
x_2 = lean_alloc_closure((void*)(l_LoVe_weakPeirce___lam__1), 2, 1);
lean_closure_set(x_2, 0, x_1);
x_3 = lean_alloc_closure((void*)(l_LoVe_weakPeirce___lam__2), 2, 1);
lean_closure_set(x_3, 0, x_2);
x_4 = lean_apply_1(x_1, x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_LoVe_weakPeirce___lam__0___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_LoVe_weakPeirce___lam__0(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
return x_3;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
lean_object* initialize_LoVe_LoVelib(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_LoVe_LoVe01__TypesAndTerms__HomeworkSheet(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_LoVe_LoVelib(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
