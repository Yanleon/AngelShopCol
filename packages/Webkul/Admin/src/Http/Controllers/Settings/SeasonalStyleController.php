<?php

namespace Webkul\Admin\Http\Controllers\Settings;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Event;
use Webkul\Admin\DataGrids\Settings\SeasonalStyleDataGrid;
use Webkul\Admin\Http\Controllers\Controller;
use Webkul\Admin\Http\Resources\SeasonalStyleResource;
use Webkul\SeasonalStyle\Repositories\SeasonalStyleRepository;

class SeasonalStyleController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(
        protected SeasonalStyleRepository $seasonalStyleRepository
    ) {}

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\View\View|\Illuminate\Http\JsonResponse
     */
    public function index()
    {
        if (request()->ajax()) {
            return datagrid(SeasonalStyleDataGrid::class)->process();
        }

        return view('admin::settings.seasonal-styles.index');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(): JsonResponse
    {
        $this->validate(request(), [
            'name' => 'required|string',
            'css'  => 'nullable|string',
        ]);

        Event::dispatch('seasonal_style.create.before');

        $seasonalStyle = $this->seasonalStyleRepository->create(request()->only([
            'name',
            'css',
        ]));

        Event::dispatch('seasonal_style.create.after', $seasonalStyle);

        return new JsonResponse([
            'message' => trans('admin::app.settings.seasonal-styles.index.create-success'),
        ]);
    }

    /**
     * Seasonal style details.
     */
    public function edit(int $id): SeasonalStyleResource
    {
        return new SeasonalStyleResource($this->seasonalStyleRepository->findOrFail($id));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(): JsonResponse
    {
        $this->validate(request(), [
            'id'   => 'required|integer',
            'name' => 'required|string',
            'css'  => 'nullable|string',
        ]);

        $id = (int) request('id');

        Event::dispatch('seasonal_style.update.before', $id);

        $seasonalStyle = $this->seasonalStyleRepository->update(request()->only([
            'name',
            'css',
        ]), $id);

        $this->seasonalStyleRepository->forgetCache();

        Event::dispatch('seasonal_style.update.after', $seasonalStyle);

        return new JsonResponse([
            'message' => trans('admin::app.settings.seasonal-styles.index.update-success'),
        ]);
    }

    /**
     * Turn the style on (turning every other one off), or off if it was on.
     */
    public function toggle(int $id): JsonResponse
    {
        abort_unless(bouncer()->hasPermission('settings.seasonal_styles.edit'), 401);

        $this->seasonalStyleRepository->activate($id);

        $isActive = $this->seasonalStyleRepository->find($id)->is_active;

        return new JsonResponse([
            'message' => trans($isActive
                ? 'admin::app.settings.seasonal-styles.index.activate-success'
                : 'admin::app.settings.seasonal-styles.index.deactivate-success'),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        try {
            Event::dispatch('seasonal_style.delete.before', $id);

            $this->seasonalStyleRepository->delete($id);

            $this->seasonalStyleRepository->forgetCache();

            Event::dispatch('seasonal_style.delete.after', $id);

            return new JsonResponse([
                'message' => trans('admin::app.settings.seasonal-styles.index.delete-success'),
            ]);
        } catch (\Exception $e) {
        }

        return new JsonResponse([
            'message' => trans('admin::app.settings.seasonal-styles.index.delete-failed'),
        ], 500);
    }
}
