<?php


use Illuminate\Support\Facades\Route;
use Contact\Http\Controllers\ContactController;

Route::group(['middleware' => ['web']], function () {
    Route::get('/contact', [ContactController::class, 'index'])->name('contact.index');
    Route::post('/contact', [ContactController::class, 'store'])->name('contact.store');
});